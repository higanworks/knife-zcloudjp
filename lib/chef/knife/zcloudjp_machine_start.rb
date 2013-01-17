require 'chef/knife/zcloudjp_base'

class Chef
  class Knife
    class ZcloudjpMachineStart < Knife
      include ZcloudjpBase
      banner "knife zcloudjp machine start (options)"


      deps do
        require 'net/ssh/multi'
        require 'readline'
        require 'chef/json_compat'
        require 'faraday'
      end

      option :machine_uuid,
        :short => "-n UUID",
        :long => "--machine-uuid UUID",
        :description => "UUID of target machne to run"

# TODO
#      option :chef_node_name,
#        :short => "-N NAME",
#        :long => "--node-name NAME",
#        :description => "The Chef node name of taget node. Will find uuid by nodename at attributes."

      option :timeout,
        :short => "-t TIMEOUT_SECONDS",
        :long => "--timeout USERNAME",
        :description => "Set Timeout(seconds). default value is 10.",
        :default => 10

      def run
        $stdout.sync = true

        unless config[:machine_uuid]
          ui.error("You have not provided a machine uuid. Please note the short option for this value is '-n'.")
          exit 1
        end
        body = Hash.new()

        Chef::Log.debug("Start machine.")
        Chef::Log.debug(body)
        

        locate_config_value(:zcloudjp_api_url)
        connection = Faraday.new(:url => locate_config_value(:zcloudjp_api_url), :ssl => {:verify => false})
 
        def check_current_state(connection,machine_uuid)
          response = connection.get do |req|
            req.url "/machines/#{machine_uuid}.json"
            req.headers['Content-Type'] = 'application/json'
            req.headers['X-API-KEY'] = Chef::Config[:knife][:zcloudjp_api_token]
          end

          Chef::Log.debug(response.inspect)
          case response.status
          when 200
            # do nothing.
          when 404
            ui.warn("The machine #{config[:machine_uuid]} was not found.")
            exit
          else
            ui.fatal("Exit", "Unknown Error occured in API response.")
            exit
          end

          machine = JSON.parse(response.body, :symbolized_names =>true )
          machine['state']
        end

        ## Exit if already runnning.
        if check_current_state(connection, config[:machine_uuid]) == "running" then
          ui.info("The machine #{config[:machine_uuid]} is already running.")
          exit
        end

        # Start Machine
        response = connection.post do |req|
          req.url "/machines/#{config[:machine_uuid]}/start.json"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-API-KEY'] = Chef::Config[:knife][:zcloudjp_api_token]
          req.body = body.to_json
        end

        ## Wait
        ui.info("Waiting state of machine changed to running... (Timeout: #{config[:timeout]} seconds)")
        config[:timeout].to_i.times do |idx|
          if check_current_state(connection, config[:machine_uuid]) == "running" then
            break
          elsif (idx + 1) == config[:timeout].to_i
            ui.warn("Timed out. Please check later.")
            exit 1
          else
              sleep 1
          end
        end

        ## print current status
        response = connection.get do |req|
          req.url "/machines/#{config[:machine_uuid]}.json"
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-API-KEY'] = Chef::Config[:knife][:zcloudjp_api_token]
          req.body = body.to_json
        end

        machine = JSON.parse(response.body, :symbolized_names =>true )

        msg_pair("ID", machine['id'])
        msg_pair("ip", machine['ips'].last)
        msg_pair("type", machine['type'])
        msg_pair("dataset", machine['dataset'])
        msg_pair("state", machine['state'])
      end

    end
  end
end

