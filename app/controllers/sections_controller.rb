class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({name: 'Default Section'})
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    # Instantiate a new object using form parameters
    @section = Section.new(section_params)
    # Save the object
    if @section.save
      # Flash Hash
      flash[:notice] = "Section created successfully!"
      # If save succeeds, redirect to the index action
      redirect_to(sections_path)
    else
      # If the save fails, redisplay the form so user can fix problems
      @section_count = Section.count + 1
      @pages = Page.sorted
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
    @pages = Page.sorted
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully!"
      redirect_to(section_path(@section))
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section '#{@section.name}' deleted successfully!"
    redirect_to(sections_path)
  end

  private

  def section_params
    params.require(:section).permit(:name, :position, :visible, :content_type, :content, :page_id)
  end
end
