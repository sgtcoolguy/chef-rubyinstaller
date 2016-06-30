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
      @url = 'http://dl.bintray.com/oneclick/rubyinstaller/rubyinstaller'
    end

    it 'installs the latest version of RubyInstaller' do
      expect(chef_run).to install_package('rubyinstaller')
        .with(source: "#{@url}-2.3.0-x64.exe")
    end

    it 'installs a specific version of RubyInstaller' do
      chef_run.node.set['rubyinstaller']['version'] = '2.2.2'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rubyinstaller')
        .with(source: "#{@url}-2.2.2-x64.exe")
    end

    it 'installs 32-bit version if matches arch' do
      chef_run.node.automatic['kernel']['machine'] = 'i686'
      chef_run.converge(described_recipe)
      expect(chef_run).to install_package('rubyinstaller')
        .with(source: "#{@url}-2.3.0.exe")
    end
  end
end
