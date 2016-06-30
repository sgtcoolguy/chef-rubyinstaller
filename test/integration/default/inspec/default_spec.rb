require 'inspec'

control 'rubyinstaller-1' do
  title 'RubyInstaller: Directory is created successfully'
  desc '
    RubyInstaller should be installed to a location without spaces.
  '

  describe file('C:\\Ruby23-x64') do
    it { should be_directory }
  end
end

control 'rubyinstaller-2' do
  title 'RubyInstaller: `ruby` command is available on the PATH'
  desc "
    It isn't enough to install RubyInstaller, we must also make sure it is
    available on the PATH as a command.
  "

  describe command('ruby -v') do
    its(:stdout) { should match(/ruby/) }
  end
end

control 'rubyinstaller-3' do
  title 'RubyInstaller: DevKit is installed'
  desc '
    So that gems with C extensions can be built, the DevKit needs to be
    installed.
  '

  describe file('C:\\DevKit-x64') do
    it { should be_directory }
  end
end

control 'rubyinstaller-4' do
  title 'RubyInstaller: Ruby is linked to DevKit'
  desc '
    The Ruby installation has to be linked to the DevKit. Otherwise
    gems like json and nokogiri cannot install
  '

  describe file('C:\\DevKit-x64\config.yml') do
    its(:content) { should match(%r{- C:\/Ruby23-x64}) }
  end

  describe command('gem install json --platform=ruby') do
    its(:stdout) { should match(/Building native extensions/) }
    its(:stdout) { should match(/Successfully installed json/) }
  end
end
