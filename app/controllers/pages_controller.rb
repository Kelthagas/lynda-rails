class PagesController < ApplicationController

  layout 'admin'

  before_action :find_subjects, only: [:new, :create, :edit, :update]
  before_action :set_page_count, only: [:new, :create, :edit, :update]

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({name: 'Default Page'})
  end

  def create
    # Instantiate a new object using form parameters
    @page = Page.new(page_params)
    # Save the object
    if @page.save
      # Flash Hash
      flash[:notice] = "Page created successfully!"
      # If save succeeds, redirect to the index action
      redirect_to(pages_path)
    else
      # If the save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully!"
      redirect_to(page_path(@page))
    else
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' deleted successfully!"
    redirect_to(pages_path)
  end

  private

  def page_params
    params.require(:page).permit(:name, :position, :visible, :permalink, :subject_id)
  end

  def find_subjects
    @subjects = Subject.sorted
  end

  def set_page_count
    @page_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count += 1
    end
  end

end
