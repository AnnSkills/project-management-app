class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
    ActsAsTenant.current_tenant = User.find_by(id: current_user.id)
    @projects = Project.all
  end

  # GET /projects/new
  def new
    @project = Project.new
    #@project = Project.new(user_id: current_user.id, account_id: current_user.account.id)
    #@project = current_user.projects.build
    #@accounts = Account.params[:current_user.account_id]
  end

  # GET /projects/1/edit
  def edit
    #@accounts = current_user.accounts
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)
    @project.users_id = current_user.id
    @project.account_id = current_user.account.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :account_id, :user_id)
      #params.require(:project).permit(:name)
    end
end
