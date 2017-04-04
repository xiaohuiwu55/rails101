class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]
  def edit
  end
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def update
   if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
