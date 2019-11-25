chef_symlinks = %w[chef-apply chef-client chef-shell chef-solo]

if os.unix?
  describe file('/tmp/testfile') do
    it { should be_file }
    its(:content) { should include 'test' }
  end

  describe file('/opt/cinc/bin/cinc-wrapper') do
    it { should be_file }
    its(:mode) { should cmp '0755' }
    its(:content) { should include 'Redirecting to' }
  end

  bin_install_path = if os.name == 'mac_os_x'
                       '/usr/local/bin'
                     else
                       '/usr/bin'
                     end

  chef_symlinks.each do |symlink|
    describe file("#{bin_install_path}/#{symlink}") do
      it { should be_symlink }
      its(:link_path) { should eq '/opt/cinc/bin/cinc-wrapper' }
    end

    describe command("#{symlink} --version") do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should include 'Redirecting to cinc' }
    end
  end
elsif os.windows?
  describe file('C:\Windows\Temp\testfile') do
    it { should be_file }
    its(:content) { should include 'test' }
  end
end
