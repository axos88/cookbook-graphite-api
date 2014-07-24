#
# Cookbook Name:: graphite-api
# Recipe:: default
#
# Copyright 2014, Olivier Dolbeau
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
#

include_recipe 'golang'
include_recipe 'golang::packages'

golang_package 'github.com/bitly/statsdaemon' do
  action :install
end

template '/etc/init.d/statsdaemon' do
  source 'statsdaemon_init.erb'
  mode 0755
  owner 'root'
  group 'root'
end

file '/var/log/statsdaemon.log' do
  owner node['go']['owner']
  group node['go']['group']
  mode '0644'
  action :create_if_missing
end

service 'statsdaemon' do
  action [:enable, :start]
  supports start: true, stop: true, restart: true
end