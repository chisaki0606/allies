class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @user = @post.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/")
    else
      render("posts/new")
    end
  end

  def edit
  end

  def update

    if @post.update!(post_params)
      flash[:notice] = "投稿を編集しました"
      redirect_to("/")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post.destroy
    
    flash[:notice] = "投稿を削除しました"
    redirect_to("/")
  end

  def show_last_messages                                                                                                            
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(8)                                              
    current_rooms = @current_user.user_rooms                                                                           
    my_room_ids = []                                                                                                   
    current_rooms.each do |user_room|                                                                                  
      my_room_ids << user_room.room.id                                                                                 
    end                                                                                                                
    @other_rooms = UserRoom.where(room_id: my_room_ids).where.not(user_id: @current_user.id)
    render("users/message_users.html.erb")                        
  end 

  private

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      redirect_to("/")
    end
  end

  def post_params
    params.require(:post).permit(Post::PERMITTED_PARAMS)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

