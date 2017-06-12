class ProjectsController < ApplicationController
  include Response
  before_action :set_project, only: [:show, :update]
  before_action :set_s3_direct_post, only: [:new]

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
    json_response(@s3_direct_post)
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

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.object(SecureRandom.uuid).presigned_url(:put, acl: 'public-read')
  end
end
