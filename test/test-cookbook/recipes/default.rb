#
# Cookbook:: test-cookbook
# Recipe:: default
#

tmp_file = case node['os']
           when 'linux', 'Darwin'
             '/tmp/testfile'
           when 'WINNT'
             'C:\Windows\Temp\testfile'
           end

file tmp_file do
  content 'test'
end
