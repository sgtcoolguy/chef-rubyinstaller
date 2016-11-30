#
# Cookbook Name:: rubyinstaller
# Spec:: default
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

require 'spec_helper'

describe 'rubyinstaller::default' do
  context 'On Windows Server 2012R2' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new version: '2012R2' do |node|
        node.automatic['kernel']['machine'] = 'x86_64'
      end
      runner.converge(described_recipe)
    end

    before do
      @base_url = 'http://dl.bintray.com/oneclick/rubyinstaller'
      @dk_base_url = "#{@base_url}/DevKit-mingw64"
      @cache_path = Chef::Config['file_cache_path']
    end

    context 'with 64-bit architecture' do
      let(:dk_version) { '64-4.7.2-20130224-1432' }
      let(:dk_pkg) { "DevKit-mingw64-#{dk_version}-sfx.exe" }

      it 'installs the latest version of RubyInstaller' do
        expect(chef_run).to install_package('rubyinstaller')
          .with(source: "#{@base_url}/rubyinstaller-2.3.0-x64.exe")
      end

      it 'installs a specific version of RubyInstaller' do
        chef_run.node.set['rubyinstaller']['version'] = '2.2.2'
        chef_run.converge(described_recipe)
        expect(chef_run).to install_package('rubyinstaller')
          .with(source: "#{@base_url}/rubyinstaller-2.2.2-x64.exe")
      end

      it 'downloads the latest CA certificate' do
        expect(chef_run).to create_remote_file('C:/Ruby23-x64/lib/ruby/2.3.0/rubygems/ssl_certs/AddTrustExternalCARoot-2048')
      end

      it 'downloads the Ruby DevKit' do
        expect(chef_run).to create_remote_file("#{@cache_path}/#{dk_pkg}")
          .with(source: "#{@dk_base_url}-64-4.7.2-20130224-1432-sfx.exe")
      end

      it 'extracts the DevKit' do
        expect(chef_run).to run_powershell_script('extract_devkit')
          .with(code: "#{@cache_path}/#{dk_pkg} -o'C:/DevKit-x64' -y")
      end

      it 'writes the DevKit configuration file' do
        expect(chef_run).to render_file('C:/DevKit-x64/config.yml')
          .with_content('- C:/Ruby23-x64')
      end

      it 'links Ruby to the DevKit' do
        expect(chef_run).to run_powershell_script('link_ruby_to_devkit')
          .with(cwd: 'C:/DevKit-x64',
                code: 'ruby dk.rb install')
      end
    end

    context 'with 32-bit architecture' do
      before do
        chef_run.node.automatic['kernel']['machine'] = 'i686'
        chef_run.converge(described_recipe)
      end

      it 'installs 32-bit version of RubyInstaller' do
        expect(chef_run).to install_package('rubyinstaller')
          .with(source: "#{@base_url}/rubyinstaller-2.3.0.exe")
      end

      it 'downloads the 32-bit version of DevKit' do
        dk_version = '32-4.7.2-20130224-1151'
        dk_pkg = "DevKit-mingw64-#{dk_version}-sfx.exe"
        expect(chef_run).to create_remote_file("#{@cache_path}/#{dk_pkg}")
          .with(source: "#{@dk_base_url}-#{dk_version}-sfx.exe")
      end
    end
  end
end
