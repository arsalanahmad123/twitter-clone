class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy require_same_user like unlike ]
  before_action :authenticate_user!, except: [:index,:show]
  before_action :require_same_user, only: [:edit,:update,:destroy]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
    @users = User.all
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def like
        @tweet.liked_by current_user
        respond_to do |format|
            format.html { redirect_to root_path }
        end
    end

    def unlike
        @tweet.unliked_by current_user
        respond_to do |format|
            format.html { redirect_to root_path }
        end
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:tweet)
    end

    def require_same_user
      if current_user && current_user = @tweet.user 
      end
    end 

end
