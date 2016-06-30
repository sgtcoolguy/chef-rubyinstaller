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
