require 'chef/knife'
require 'knife-zcloudjp'

class Chef
  class Knife
    class ZcloudjpProductList < Knife
      include ZcloudjpBase

      banner "knife zcloudjp product list (options)"

      def run
        Chef::Log.debug("Connect to Z Cloud API #{locate_config_value(:zcloudjp_api_url)}")

        response = HTTParty.get(
                     "#{Chef::Config[:knife][:zcloudjp_api_url]}/products.json",
                     :headers => {"X-API-KEY" => Chef::Config[:knife][:zcloudjp_api_token]}
                   )

        products = JSON.parse(response.body)

        product_list = [
          ui.color('name', :bold),
          ui.color('os', :bold),
          ui.color('dataset', :bold),
          ui.color('package', :bold),
        ]

        products.map do |product|
          product_list << product["name"]
          product_list << product["os"]
          product_list << product["sdc_dataset"]
          product_list << product["sdc_package"]
        end

        puts ui.list(product_list, :uneven_columns_across, 4)
      end
    end
  end
end
