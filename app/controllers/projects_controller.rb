class ProjectsController < ApplicationController
  include Response
  before_action :set_project, only: [:show, :update]
  # before_action :set_s3_direct_post, only: [:create, :update]

  # GET /todos
  def index
    search = params[:search]
    if search
      @projects = Project.where('lower(name) LIKE ?', "%" + search.downcase + "%")
    else
      @projects = Project.all
    end
    json_response(@projects)
  end

  # GET /todos/new
  def new
    @project = Project.new
    json_response(@project)
  end

  # POST /todos
  def create
    @project = Project.create!(project_params)
    json_response(@project, :created)
  end

  # GET /todos/:id
  def show
    json_response(@project)
  end

  # PUT /todos/:id
  def update
    @project.update(project_params)
    head :no_content
  end

  private

  def project_params
    params.permit(:name, :price, :image)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  # def set_s3_direct_post
  #   @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  # end
end
