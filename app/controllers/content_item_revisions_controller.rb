class ContentItemRevisionsController < ApplicationController
  before_action :set_content_item
  before_action :set_content_item_revision, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /content_item_revisions
  # GET /content_item_revisions.json
  def index
    @content_item_revisions = @content_item.content_item_revisions
  end

  # GET /content_item_revisions/1
  # GET /content_item_revisions/1.json
  def show
  end

  # GET /content_item_revisions/new
  def new
    @content_item_revision = ContentItemRevision.new
    if params[:parent] && parent = ContentItemRevision.find(params[:parent])
      @content_item_revision.parent = parent
      @content_item_revision.content = parent.content
    end
    if params[:change_set] && change_set = ChangeSet.find(params[:change_set])
      @content_item_revision.change_set = change_set
    end
  end

  # GET /content_item_revisions/1/edit
  def edit
  end

  # POST /content_item_revisions
  # POST /content_item_revisions.json
  def create
    @content_item_revision = ContentItemRevision.new(content_item_revision_params)
    @content_item_revision.creator = current_user
    @content_item_revision.modifier = current_user
    @content_item_revision.content_item = @content_item
    respond_to do |format|
      if @content_item_revision.save
        format.html { redirect_to content_item_content_item_revisions_path(@content_item), notice: 'Content item revision was successfully created.' }
        format.json { render :show, status: :created, location: @content_item_revision }
      else
        format.html { render :new }
        format.json { render json: @content_item_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_item_revisions/1
  # PATCH/PUT /content_item_revisions/1.json
  def update
    @content_item_revision.modifier = current_user
    respond_to do |format|
      if @content_item_revision.update(content_item_revision_params)
        format.html { redirect_to content_item_content_item_revision_path(@content_item, @content_item_revision), notice: 'Content item revision was successfully updated.' }
        format.json { render :show, status: :ok, location: @content_item_revision }
      else
        format.html { render :edit }
        format.json { render json: @content_item_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_item_revisions/1
  # DELETE /content_item_revisions/1.json
  def destroy
    @content_item_revision.destroy
    respond_to do |format|
      format.html { redirect_to content_item_revisions_url, notice: 'Content item revision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_content_item
      @content_item = ContentItem.find(params[:content_item_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_content_item_revision
      @content_item_revision = ContentItemRevision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_item_revision_params
      params.require(:content_item_revision).permit(:content, :content_item_revision_id, :created_by, :last_modified_by, :change_set_id, :identifier)
    end
end
