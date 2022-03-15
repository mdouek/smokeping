#
# Cookbook:: smokeping
# Recipe:: default
#
# Copyright:: 2013-2016, Limelight Networks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

service 'apache2' do
  service_name 'apache2'
  supports restart: true, status: true, reload: true
  action :nothing
end

apache2_module 'cgi'

file '/etc/smokeping/apache2.config' do
  action :delete
end

template '/etc/apache2/sites-available/smokeping.conf' do
  source 'apache2.erb'
  mode '0644'
  notifies :reload, 'service[apache2]'
end

apache2_site 'smokeping' do
  action :enable
end

apache2_site '000-default' do
  action :disable
end
