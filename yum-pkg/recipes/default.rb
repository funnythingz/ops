#
# Cookbook Name:: yum-pkg
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

%w[openssl openssl-devel].each do |pkg|
  package pkg do
    action :install
  end
end
