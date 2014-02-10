require 'chef/knife/zcloudjp_base'

class Chef
  class Knife
    class ZcloudjpMachineStop < Knife
      include ZcloudjpBase
      banner "knife zcloudjp machine stop (options)"


      deps do
        require 'chef/json_compat'
      end

      option :machine_uuid,
        :short => "-n UUID",
        :long => "--machine-uuid UUID",
        :description => "UUID of target machne to stop"

# TODO
#      option :chef_node_name,
#        :short => "-N NAME",
#        :long => "--node-name NAME",
#        :description => "The Chef node name of taget node. Will find uuid by nodename at attributes."

      option :timeout,
        :short => "-t TIMEOUT_SECONDS",
        :long => "--timeout USERNAME",
        :description => "Set Timeout(seconds). default value is 20.",
        :default => 20

      def run
        $stdout.sync = true

        unless config[:machine_uuid]
          ui.error("You have not provided a machine uuid. Please note the short option for this value is '-n'.")
          exit 1
        end

        Chef::Log.debug("Stop machine.")

        locate_config_value(:zcloudjp_api_url)
        machine = client.machine.show(:id => config[:machine_uuid])

        ## Exit if missing
        if machine[:error]
          ui.warn("The machine #{config[:machine_uuid]} was not found.")
          exit
        end

        ## Exit if already stopped.
        if machine[:state] == "stopped" then
          ui.info("The machine #{config[:machine_uuid]} already stopped.")
          exit
        end

        # Stop Machine
        machine.stop

        ## Wait
        ui.info("Waiting state of machine changed to stopped... (Timeout: #{config[:timeout]} seconds)")
        config[:timeout].to_i.times do |idx|
          if machine.reload[:state] == "stopped" then
            puts ''
            break
          elsif (idx + 2) == config[:timeout].to_i
            ui.warn("Timed out. Please check later.")
            exit 1
          else
            print '.'
            sleep 2
          end
        end

        ## print current status
        msg_pair("ID", machine['id'])
        msg_pair("ip", machine['ips'].last)
        msg_pair("type", machine['type'])
        msg_pair("dataset", machine['dataset'])
        msg_pair("state", machine['state'])
      end

    end
  end
end

