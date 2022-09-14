class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def index
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids])  #自分とフォローしているユーザの投稿を全件取得
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def search
    @range = params[:range]

    if @range == 'User'
      @users = User.search(params[:word])
      @word = params[:word]
    else
      @posts = Post.search(params[:word])
      @word = params[:word]
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:image, :introduction, :user_id)
  end

end