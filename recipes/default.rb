#
# Cookbook Name:: rubyinstaller
# Recipe:: default
#
# Copyright 2016 Evan Machnic
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

include_recipe 'chef-sugar::default'

if windows?
  base_url    = 'http://dl.bintray.com/oneclick/rubyinstaller'
  ri_version  = node['rubyinstaller']['version']
  ri_base_url = "#{base_url}/rubyinstaller-#{ri_version}"
  chef_cache  = Chef::Config['file_cache_path']

  if _64_bit?
    ri_source_url = "#{ri_base_url}-x64.exe"
    dk_pkg_name   = 'DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe'
    dk_path       = 'C:/DevKit-x64'
  else
    ri_source_url = "#{ri_base_url}.exe"
    dk_pkg_name   = 'DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe'
    dk_path       = 'C:/DevKit'
  end

  package 'rubyinstaller' do
    source ri_source_url
    not_if { ::File.exist? node['rubyinstaller']['path'] }
  end

  windows_path "#{node['rubyinstaller']['path']}/bin" do
    action :add
  end

  remote_file "#{node['rubyinstaller']['cert_path']}/AddTrustExternalCARoot-2048" do
    source 'http://curl.haxx.se/ca/cacert.pem'
  end

  remote_file "#{chef_cache}/#{dk_pkg_name}" do
    source "#{base_url}/#{dk_pkg_name}"
  end

  powershell_script 'extract_devkit' do
    code "#{chef_cache}/#{dk_pkg_name} -o'#{dk_path}' -y"
    not_if { ::File.exist? dk_path }
  end

  template "#{dk_path}/config.yml" do
    source 'config.yml.erb'
  end

  powershell_script 'link_ruby_to_devkit' do
    cwd dk_path
    code 'ruby dk.rb install'
  end
end
