require 'chef/knife'

class Chef
  class Knife
    class ZcloudjpProductList < Knife
      include ZcloudjpBase

      banner "knife zcloudjp product list (options)"

      def run
        # TODO
        # Retrieve the product data dynamically
        # from the Niboshi REST API.

        productjson = File::expand_path('../../../../data/products_2012-10.json', __FILE__)
        products = JSON.parse(File.read(productjson))

        product_list = [
          ui.color('name', :bold),
          ui.color('os', :bold),
          ui.color('dataset', :bold),
          ui.color('package', :bold),
        ]

        products.map do |product|
          product_list << product["name"]
          product_list << product["os"]
          product_list << product["dataset"]
          product_list << product["package"]
        end

        puts ui.list(product_list, :uneven_columns_across, 4)
      end
    end
  end
end
