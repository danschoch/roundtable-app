class CommentsController < ApplicationController
    before_action :require_login

    def index
        @comments = Comment.all.select{|comment| comment.task_id.to_s == params[:task_id]}.last(10)
        respond_to do |format|
            format.html { render "/projects" }
            format.json { render json: @comments, status:201 }
        end
    end
    
    def new
        @user = current_user
    end

    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment, status: 201
        else
            redirect_to task_path(params[:task_id]) #Could do flash message for no comment content
        end
    end

    def show
        comment = Comment.find(params[:id])
        render json: comment, status: 200
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :task_id, :employee_id)
    end

end
