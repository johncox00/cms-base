class ContentItemsController < ApplicationController
  before_action :set_content_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  # GET /content_items
  # GET /content_items.json
  def index
    @content_items = ContentItem.all
  end

  # GET /content_items/1
  # GET /content_items/1.json
  def show
  end

  # GET /content_items/new
  def new
    @content_item = ContentItem.new
  end

  # GET /content_items/1/edit
  def edit
  end

  # POST /content_items
  # POST /content_items.json
  def create
    @content_item = ContentItem.new(content_item_params)

    respond_to do |format|
      if @content_item.save
        format.html { redirect_to @content_item, notice: 'Content item was successfully created.' }
        format.json { render :show, status: :created, location: @content_item }
      else
        format.html { render :new }
        format.json { render json: @content_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_items/1
  # PATCH/PUT /content_items/1.json
  def update
    respond_to do |format|
      if @content_item.update(content_item_params)
        format.html { redirect_to @content_item, notice: 'Content item was successfully updated.' }
        format.json { render :show, status: :ok, location: @content_item }
      else
        format.html { render :edit }
        format.json { render json: @content_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_items/1
  # DELETE /content_items/1.json
  def destroy
    @content_item.destroy
    respond_to do |format|
      format.html { redirect_to content_items_url, notice: 'Content item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_item
      @content_item = ContentItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_item_params
      params.require(:content_item).permit(:identifier, :container_id, :description)
    end
end
