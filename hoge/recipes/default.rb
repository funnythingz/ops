#
# Cookbook Name:: hoge
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

template ".vimrc" do
  owner  "vagrant"
  group  "vagrant"
  mode   "0644"
  path   "/home/vagrant/.vimrc"
  source ".vimrc.erb"
end

git "/home/vagrant/.rbenv" do
  repository "https://github.com/sstephenson/rbenv.git"
  revision   "master"
  user       "vagrant"
  group      "vagrant"
  action     :sync
end

directory "/home/vagrant/.rbenv/plugins" do
  owner  "vagrant"
  group  "vagrant"
  action :create
end

git "/home/vagrant/.rbenv/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  revision   "master"
  user       "vagrant"
  group      "vagrant"
  action     :sync
end

%w{.bash_profile .bashrc}.each do |filename|
  template filename do
    owner  "vagrant"
    group  "vagrant"
    mode   "0644"
    path   "/home/vagrant/#{filename}"
    source "#{filename}.erb"
  end
end

template "rbenv.sh" do
  owner  "vagrant"
  group  "vagrant"
  path   "/home/vagrant/rbenv.sh"
  source "rbenv.sh.erb"
end

bash "rbenv install 2.1.5" do
  user   "vagrant"
  cwd    "/home/vagrant"
  code   "source rbenv.sh; rbenv install 2.1.5"
  action :run
  not_if { ::File.exists? "/home/vagrant/.rbenv/versions/2.1.5" }
end

bash "rbenv rehash" do
  user   "vagrant"
  cwd    "/home/vagrant"
  code   "source rbenv.sh; rbenv rehash"
  action :run
end

bash "rbenv global 2.1.5" do
  user   "vagrant"
  cwd    "/home/vagrant"
  code   "source rbenv.sh; rbenv global 2.1.5"
  action :run
end
