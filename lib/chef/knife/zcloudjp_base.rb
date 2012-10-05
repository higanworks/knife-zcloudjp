require 'chef/knife'

class Chef
  class Knife
    module ZcloudBase

      def self.included(includer)
        includer.class_eval do

          deps do
            require 'net/ssh/multi'
            require 'readline'
            require 'chef/json_compat'
            require 'faraday'
          end

          option :zcloud_api_token,
            :short => "-K KEY",
            :long => "--zcloud-api-token",
            :description  => "Your Z cloud API token",
            :proc => Proc.new { |key| Chef::Config[:knife][:zcloud_api_token] = key }

          option :zcloud_api_url,
            :long => "--zcloud-api-auth-url URL",
            :description => "Your Z Cloud API url",
            :default => "https://my.z-cloud.jp",
            :proc => Proc.new { |url| Chef::Config[:knife][:zcloud_api_url] = url }
        end
      end

      def connection
        @connection = Faraday.new(:url => Chef::Config[:knife][:zcloud_api_url]) do |faraday|
            faraday.request  :url_encoded
        end
      end


    end
  end
end
