require 'inspec'

control 'rubyinstaller-1' do
  title 'RubyInstaller: Directory is created successfully'
  desc '
    RubyInstaller should be installed to a location without spaces.
  '

  describe file('C:\\Ruby22-x64') do
    it { should be_directory }
  end
end
