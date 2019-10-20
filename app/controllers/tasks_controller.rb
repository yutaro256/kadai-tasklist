class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    require_user_logged_in
    @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました"
      redirect_to tasks_url
    else
      flash.now[:danger] = "タスクが作成できませんでした"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました"
      redirect_to tasks_url
    else
      flash.now[:danger] = "タスクが更新できませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクが正常に削除されました"
    redirect_to tasks_url
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end
  
  
  