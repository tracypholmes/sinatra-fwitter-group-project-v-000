class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  # fin by id code 'inspired' by J
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == current_user.id
        erb :'/tweets/edit_tweet'
      else
        redirect to "/tweets/#{params[:id]}"
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      tweet = current_user.tweets.find_by(id: params[:id])
      if params.value?('')
        redirect to "/tweets/#{params[:id]}/edit"
      else
        tweet.update(content: params[:content])
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params.value?('')
      redirect to '/tweets/new'
    else
      user = User.find(session[:user_id])
      Tweet.create(user_id: user.id, content: params[:content])
      redirect to '/tweets'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      tweet = current_user.tweets.find_by_id(params[:id])
      if tweet
        tweet.delete
        redirect to '/tweets'
      else
        redirect to "/tweets/#{params[:id]}"
      end
    end
  end
end
