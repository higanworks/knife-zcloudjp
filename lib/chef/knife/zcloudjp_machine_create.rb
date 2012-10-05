require 'chef/knife/zcloudjp_base'

class Chef
  class Knife
    class ZcloudjpMachineCreate < Knife
      include ZcloudjpBase
      banner "knife zcloudjp machine create (options)"


      deps do
        require 'net/ssh/multi'
        require 'readline'
        require 'chef/json_compat'
        require 'faraday'
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end

      option :package,
        :short => "-p PACKAGE",
        :long => "--package PACKAGE",
        :description => "Package of machine; default is Small_1GB",
        :proc => Proc.new { |p| Chef::Config[:knife][:zcloud_package] = p },
        :default => "Small_1GB"

      option :dataset,
        :short => "-I DATASET_IMAGE",
        :long => "--dataset-image DATASET_IMAGE",
        :description => "Dataset image of the machine",
        :proc => Proc.new { |i| Chef::Config[:knife][:zcloud_dataset] = i }

      option :machine_name,
        :short => "-n NAME",
        :long => "--machine-name NAME",
        :description => "Name tag value for your new machne (dafault uuid's first period)"

      option :chef_node_name,
        :short => "-N NAME",
        :long => "--node-name NAME",
        :description => "The Chef node name for your new node (default uuid)"

      option :ssh_user,
        :short => "-x USERNAME",
        :long => "--ssh-user USERNAME",
        :description => "The ssh username; default is 'root'",
        :default => "root"

      option :identity_file,
        :short => "-i IDENTITY_FILE",
        :long => "--identity-file IDENTITY_FILE",
        :description => "The SSH identity file used for authentication"

      option :prerelease,
        :long => "--prerelease",
        :description => "Install the pre-release chef gems"

      option :bootstrap_version,
        :long => "--bootstrap-version VERSION",
        :description => "The version of Chef to install",
        :proc => Proc.new { |v| Chef::Config[:knife][:bootstrap_version] = v }

      option :distro,
        :short => "-d DISTRO",
        :long => "--distro DISTRO",
        :description => "Bootstrap a distro using a template; default is 'chef-full'",
        :proc => Proc.new { |d| Chef::Config[:knife][:distro] = d },
        :default => "chef-full"

      option :template_file,
        :long => "--template-file TEMPLATE",
        :description => "Full path to location of template to use",
        :proc => Proc.new { |t| Chef::Config[:knife][:template_file] = t },
        :default => false

      option :run_list,
        :short => "-r RUN_LIST",
        :long => "--run-list RUN_LIST",
        :description => "Comma separated list of roles/recipes to apply",
        :proc => lambda { |o| o.split(/[\s,]+/) },
        :default => []

      option :first_boot_attributes,
        :short => "-j JSON_ATTRIBS",
        :long => "--json-attributes",
        :description => "A JSON string to be added to the first run of chef-client",
        :proc => lambda { |o| JSON.parse(o) },
        :default => {}

      option :zcloud_metadata,
        :short => "-M JSON",
        :long => "--zcloud-metadata JSON",
        :description => "JSON string version of metadata hash to be supplied with the machine create call",
        :proc => Proc.new { |m| Chef::Config[:knife][:zcloud_metadata] = JSON.parse(m) },
        :default => ""

      option :host_key_verify,
        :long => "--[no-]host-key-verify",
        :description => "Verify host key, disabled by default",
        :boolean => true,
        :default => false


      def verify_ssh_connection(hostname)
        tcp_socket = TCPSocket.new(hostname, 22)
        readable = IO.select([tcp_socket], nil, nil, 5)
        if readable
          Chef::Log.debug("sshd accepting connections on #{hostname}, banner is #{tcp_socket.gets}")
          yield
          true
        else
          false
        end
      rescue Errno::ETIMEDOUT
        false
      rescue Errno::EPERM
        false
      rescue Errno::ECONNREFUSED
        sleep 2
        false
      rescue Errno::EHOSTUNREACH
        sleep 2
        false
      rescue Errno::ENETUNREACH
        sleep 2
        false
      ensure
        tcp_socket && tcp_socket.close
      end



      def run
        $stdout.sync = true

        unless Chef::Config[:knife][:zcloud_dataset]
          ui.error("You have not provided a valid dataset image value. Please note the short option for this value recently changed from '-i' to '-I'.")
          exit 1
        end
        body = Hash.new()
        body["dataset"]   = config[:dataset]
        body["package"]   = config[:package]
        body["name"]      = config[:chef_node_name]

        connection = Faraday.new(:url => Chef::Config[:knife][:zcloud_api_url], :ssl => {:verify => false})
 
        response = connection.post do |req|
          req.url '/machines.json'
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-API-KEY'] = Chef::Config[:knife][:zcloud_api_token]
          req.body = body.to_json
        end

        machine = JSON.parse(response.body, :symbolized_names =>true )

        msg_pair("ID", machine['id'])
        msg_pair("ip", machine['ips'].last)
        msg_pair("type", machine['type'])
        msg_pair("dataset", machine['dataset'])
        msg_pair("package", machine['packeage'])
        msg_pair("state", machine['state'])

        bootstrap_ip_address = machine['ips'].last
        config[:chef_node_name] = machine['id'] unless config[:chef_node_name]
        config[:machine_name] = machine['id'].split("/")[0] unless config[:machine_name]

        # wait for provision the machine.
        print(".") until verify_ssh_connection(bootstrap_ip_address) {
          sleep @initial_sleep_delay ||= 10
          # puts("done")
        }

        # for smartdc workaround. check twice.
        sleep 10

        # wait for provision the machine.
        print(".") until verify_ssh_connection(bootstrap_ip_address) {
          sleep @initial_sleep_delay ||= 10
          puts("done")
        }

        # add name tag for zcloud machine
        body = Hash.new()
        body["value"]   = config[:machine_name]

        response = connection.put do |req|
          req.url "/machines/#{machine['id']}/name"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-API-KEY'] = Chef::Config[:knife][:zcloud_api_token]
          req.body = body.to_json
        end

        bootstrap_node(machine, bootstrap_ip_address).run
      end

      def bootstrap_node(machine, bootstrap_ip_address)
        bootstrap = Chef::Knife::Bootstrap.new
        bootstrap.name_args = [bootstrap_ip_address]
        bootstrap.config[:run_list] = config[:run_list]
        bootstrap.config[:first_boot_attributes] = config[:first_boot_attributes]
        bootstrap.config[:ssh_user] = config[:ssh_user] || "root"
        # bootstrap.config[:ssh_password] = machine.password
        bootstrap.config[:identity_file] = config[:identity_file]
        bootstrap.config[:host_key_verify] = config[:host_key_verify]
        bootstrap.config[:chef_node_name] = config[:chef_node_name] || server.id
        bootstrap.config[:prerelease] = config[:prerelease]
        bootstrap.config[:bootstrap_version] = locate_config_value(:bootstrap_version)
        bootstrap.config[:distro] = locate_config_value(:distro)
        # bootstrap will run as root...sudo (by default) also messes up Ohai on CentOS boxes
        bootstrap.config[:use_sudo] = true unless config[:ssh_user] == 'root'
        bootstrap.config[:template_file] = locate_config_value(:template_file)
        bootstrap.config[:environment] = config[:environment]
        bootstrap
      end
    end
  end
end

