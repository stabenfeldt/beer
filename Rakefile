# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'motion-testflight'
require 'bundler'
Bundler.require

require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.info_plist['UIStatusBarHidden'] = true
  app.frameworks += ['CoreLocation', 'MapKit', 'AddressBook']

  app.name = 'Beer Places'

  # TestFlight
  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = 'ce6bb8a7-57e5-42f2-bb72-e10d0e2dc3c0'
  app.testflight.team_token = 'aed3eb5f93c212172f99a80b13f1df55_MjI1OTkxMjAxMy0wNi0wNSAxNTo1NTowMC4xNDcyMzA'
  app.entitlements['get-task-allow'] = false
  
end
