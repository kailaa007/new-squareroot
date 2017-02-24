class Admin::ChecklistsController < Admin::ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]

  # GET /checklists
  def index
    @checklists = Checklist.all
  end

  # GET /checklists/1
  def show
  end

  # GET /checklists/new
  def new
    @checklist = Checklist.new
  end

  # GET /checklists/1/edit
  def edit
  end

  # POST /checklists
  def create
    @checklist = Checklist.new(checklist_params)

    if @checklist.save
      redirect_to admin_checklists_path, notice: 'Checklist was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /checklists/1
  def update
    if @checklist.update(checklist_params)
      redirect_to admin_checklist_path(@checklist), notice: 'Checklist was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /checklists/1
  def destroy
    @checklist.destroy
    redirect_to admin_checklists_path, notice: 'Checklist was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checklist
      @checklist = Checklist.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def checklist_params
      params.require(:checklist).permit(:title, :category, :sub_category)
    end
end
