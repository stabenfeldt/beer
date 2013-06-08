# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'motion-testflight'
require 'bundler'
Bundler.require

require 'bubble-wrap'

Motion::Project::App.setup do |app|
  app.info_plist['UIStatusBarHidden'] = true
  app.frameworks += ['CoreLocation', 'MapKit', 'AddressBook']

  app.name = 'iSola'
  app.codesign_certificate = 'iPhone Distribution: Martin Stabenfeldt (BJA8JRNT55)' 
  app.identifier = 'no.martinstabenfeldt.iSola'
  app.provisioning_profile = "/Users/martins/Dropbox/Development/iSola_beta.mobileprovision"

  # TestFlight
  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = '14277d134c042b2ff63c28578d0ba491_MTA1OTg5NjIwMTMtMDUtMjAgMTA6NTY6NDYuNDg3MTc4'
  app.testflight.team_token = 'aed3eb5f93c212172f99a80b13f1df55_MjI1OTkxMjAxMy0wNi0wNSAxNTo1NTowMC4xNDcyMzA'
  app.entitlements['get-task-allow'] = false
  
end
