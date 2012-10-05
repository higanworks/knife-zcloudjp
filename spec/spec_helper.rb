$:.unshift File.expand_path('../../lib', File.dirname(__FILE__))

require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'chef'
require 'chef/knife/bootstrap'
require 'chef/knife/zcloudjp_base'
require 'chef/knife/zcloudjp_machine_create'
require 'chef/knife/zcloudjp_machine_list'
require 'chef/knife/zcloudjp_product_list'
