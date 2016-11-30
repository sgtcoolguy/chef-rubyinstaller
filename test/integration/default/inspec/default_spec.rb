describe file('C:\\Ruby23-x64') do
  it { should be_directory }
end

describe command('ruby -v') do
  its(:stdout) { should match(/ruby/) }
end

describe file('c:/Ruby23-x64/lib/ruby/2.3.0/rubygems/ssl_certs/AddTrustExternalCARoot-2048') do
  it { should be_file }
end

describe file('C:\\DevKit-x64') do
  it { should be_directory }
end

describe file('C:\\DevKit-x64\config.yml') do
  its(:content) { should match(%r{- C:\/Ruby23-x64}) }
end
