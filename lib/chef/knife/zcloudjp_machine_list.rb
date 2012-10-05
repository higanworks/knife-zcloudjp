require 'chef/knife/zcloudjp_base'

class Chef
  class Knife
    class ZcloudMachineList <Knife
      include ZcloudBase
      banner "knife zcloud machine list (options)"

      def run
        connection = Faraday.new(:url => Chef::Config[:knife][:zcloud_api_url])

        response = connection.get do |req|
          req.url '/machines.json'
          req.headers['Content-Type'] = 'application/json'
          req.headers['X-API-KEY'] = Chef::Config[:knife][:zcloud_api_token]
        end

        machine_list = [
          ui.color('name', :bold),
          ui.color('id', :bold),
          ui.color('ips', :bold),
          ui.color('dataset', :bold),
          ui.color('package', :bold),
          ui.color('state', :bold),
        ]
        
        machines = JSON.parse(response.body)

        machines.map do |machine|
          machine_list << machine["name"].to_s
          machine_list << machine["id"].to_s
          machine_list << machine["ips"].to_s
          machine_list << machine["dataset"]
          machine_list << machine["package"]
          machine_list << machine["state"]
        end

        puts ui.list(machine_list, :uneven_columns_across, 6)

      end
    end
  end
end

