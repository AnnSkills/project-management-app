class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_proj_tenant

<<<<<<< HEAD
=======
  # GET /projects or /projects.json
>>>>>>> new
  def index
    @projects = Project.all
  end

<<<<<<< HEAD
=======
  # GET /projects/1 or /projects/1.json
>>>>>>> new
  def show
    @projects = Project.all
  end

<<<<<<< HEAD
=======
  # GET /projects/new
>>>>>>> new
  def new
    @project = Project.new
  end

<<<<<<< HEAD
  def edit
  end

  def create
    ActsAsTenant.with_tenant(current_account) do
      @project = Project.new(project_params)
      @project.account_id = current_account.id
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
  end

=======
  # GET /projects/1/edit
  def edit
    #@accounts = current_user.accounts
  end

  # POST /projects or /projects.json
  def create
    ActsAsTenant.with_tenant(current_account) do
      puts current_account.name
      puts current_account.user_id
    @project = Project.new(project_params)
    @project.account_id = current_account.id
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
  end

  # PATCH/PUT /projects/1 or /projects/1.json
>>>>>>> new
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

<<<<<<< HEAD
=======
  # DELETE /projects/1 or /projects/1.json
>>>>>>> new
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
<<<<<<< HEAD

    def set_project
      @project = Project.find(params[:id])
    end

=======
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      #ActsAsTenant.current_tenant = current_account
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
>>>>>>> new
    def project_params
      params.require(:project).permit(:name, :account_id)
    end

  def set_proj_tenant
    if user_signed_in?
      ActsAsTenant.current_tenant = current_account
    end
  end
end
