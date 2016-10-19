class ChangeSetsController < ApplicationController
  before_action :set_change_set, only: [:show, :edit, :update, :destroy, :accept, :reject]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /change_sets
  # GET /change_sets.json
  def index
    @current_change_sets = ChangeSet.current
    @future_change_sets = ChangeSet.future
    @past_change_sets = ChangeSet.past
  end

  # GET /change_sets/1
  # GET /change_sets/1.json
  def show
    @change_set.review! if current_user.content_approver? && !@change_set.being_reviewed? && !@change_set.accepted? && !@change_set.rejected?
  end

  # GET /change_sets/new
  def new
    @change_set = ChangeSet.new
  end

  # GET /change_sets/1/edit
  def edit
  end

  # POST /change_sets
  # POST /change_sets.json
  def create
    @change_set = ChangeSet.new(change_set_params)
    @change_set.owner = current_user
    respond_to do |format|
      if @change_set.save
        @change_set.submit!
        format.html { redirect_to @change_set, notice: 'Change set was successfully created.' }
        format.json { render :show, status: :created, location: @change_set }
      else
        format.html { render :new }
        format.json { render json: @change_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /change_sets/1
  # PATCH/PUT /change_sets/1.json
  def update
    respond_to do |format|
      if @change_set.update(change_set_params)
        @change_set.submit!
        format.html { redirect_to @change_set, notice: 'Change set was successfully updated.' }
        format.json { render :show, status: :ok, location: @change_set }
      else
        format.html { render :edit }
        format.json { render json: @change_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /change_sets/1
  # DELETE /change_sets/1.json
  def destroy
    @change_set.destroy
    respond_to do |format|
      format.html { redirect_to change_sets_url, notice: 'Change set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    authorize! :accept, @change_set
    @change_set.accept!
    respond_to do |format|
      format.html { redirect_to change_sets_url, notice: 'Change set was successfully accepted.' }
      format.json { head :no_content }
    end
  end

  def reject
    authorize! :reject, @change_set
    @change_set.reject!
    respond_to do |format|
      format.html { redirect_to change_sets_url, notice: 'Change set was successfully rejected.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_change_set
      @change_set = ChangeSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def change_set_params
      params.require(:change_set).permit(:created_by, :active_at, :inactive_at, :name)
    end
end
