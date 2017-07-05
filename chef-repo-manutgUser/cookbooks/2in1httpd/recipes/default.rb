#
# Cookbook Name:: 2in1httpd
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'Install sambaAndMinicom' do
  case node[:platform]
  when 'redhat', 'centos'
    package_name 'httpd'
  when 'ubuntu', 'debian'
    package_name 'apache2'
  end
end

cookbook_file "/var/www/html/index.html" do
	source "index.html"
	mode "0644"
	end

service 'example_service' do
	case node['platform']
	when 'centos','redhat','fedora'
		service_name 'httpd'
		action [ :enable, :start ]
	else
		service_name 'apache2'
		supports :status => true, :restart => true, :reload => true
	end
end
