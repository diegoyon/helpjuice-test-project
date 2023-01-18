class ApplicationController < ActionController::Base
  # request authentication to use the app
  before_action :authenticate_user!
  require 'will_paginate/array'
end
