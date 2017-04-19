class IdeasController < ApplicationController
  def index
    @ideas = Idea.all
    @current_user = current_user
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def create
    idea = Idea.new(idea_params.merge(user: current_user))
    if idea.save
      redirect_to "/ideas"
    end
    flash[:idea_errors] = idea.errors.full_messages
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy if @idea.user === current_user
    redirect_to "/ideas"
  end

  private
    def idea_params
      params.require(:idea).permit(:idea)
    end
end
