describe file('C:\\Ruby23-x64') do
  it { should be_directory }
end

describe command('ruby -v') do
  its(:stdout) { should match(/ruby/) }
end

describe file('C:\\DevKit-x64') do
  it { should be_directory }
end

describe file('C:\\DevKit-x64\config.yml') do
  its(:content) { should match(%r{- C:\/Ruby23-x64}) }
end

describe command('gem install json --platform=ruby') do
  its(:stdout) { should match(/Building native extensions/) }
  its(:stdout) { should match(/Successfully installed json/) }
end
