require './config/environment'
require 'securerandom'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
set :session_secret, "fwitter_secret"
    # set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    # set :session_secret, SecureRandom.hex(64)
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?

      !!session[:user_id]
    end

    def current_user
       @current_user ||= User.find(session[:user_id])
        # User.find(session[:user_id])
    end
  end
end
