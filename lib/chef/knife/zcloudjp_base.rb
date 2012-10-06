require 'chef/knife'

class Chef
  class Knife
    module ZcloudjpBase

      def self.included(includer)
        includer.class_eval do

          deps do
            require 'net/ssh/multi'
            require 'readline'
            require 'chef/json_compat'
            require 'faraday'
          end

          option :zcloudjp_api_token,
            :short => "-K KEY",
            :long => "--zcloudjp-api-token",
            :description  => "Your Z cloud API token",
            :proc => Proc.new { |key| Chef::Config[:knife][:zcloudjp_api_token] = key }

          option :zcloudjp_api_url,
            :long => "--zcloudjp-api-auth-url URL",
            :description => "Your Z Cloud API url",
            :proc => Proc.new { |url| Chef::Config[:knife][:zcloudjp_api_url] = url },
            :default => "https://my.z-cloud.jp"
        end
      end

    private

      def connection
        @connection = Faraday.new(:url => Chef::Config[:knife][:zcloudjp_api_url]) do |faraday|
          faraday.request  :url_encoded
        end
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
