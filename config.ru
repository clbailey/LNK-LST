require 'rubygems'
require 'bundler'

Bundler.require

require "./lnk-lst"

run Sinatra::Application
