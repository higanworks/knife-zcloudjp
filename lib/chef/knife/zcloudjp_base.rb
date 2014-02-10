require 'chef/knife'
require 'knife-zcloudjp'

class Chef
  class Knife
    module ZcloudjpBase

      def self.included(includer)
        includer.class_eval do

          deps do
            require 'net/ssh/multi'
            require 'zcloudjp'
            require 'chef/json_compat'
          end

          option :zcloudjp_api_token,
            :short => "-K KEY",
            :long => "--zcloudjp-api-token",
            :description  => "Your Z cloud API token",
            :proc => Proc.new { |key| Chef::Config[:knife][:zcloudjp_api_token] = key }

          option :zcloudjp_api_url,
            :long => "--zcloudjp-api-auth-url URL",
            :description => "Your Z Cloud API url",
            :default => "https://my.z-cloud.jp",
            :proc => Proc.new { |url| Chef::Config[:knife][:zcloudjp_api_url] = url }
        end
      end

    private

      def client
        Zcloudjp::Client.new(:api_key => Chef::Config[:knife][:zcloudjp_api_token])
      end

      def locate_config_value(key)
        key = key.to_sym
        Chef::Config[:knife][key] || config[key]
      end

      def msg_pair(label, value, color=:cyan)
        if value && !value.to_s.empty?
          puts "#{ui.color(label, color)}: #{value}"
        end
      end

    end
  end
end
