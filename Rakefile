# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'bundler'
Bundler.require

require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.info_plist['UIStatusBarHidden'] = true
  app.frameworks += ['CoreLocation', 'MapKit', 'AddressBook']
  

  app.name = 'Beer Places'
end
