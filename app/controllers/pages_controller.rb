class PagesController < ApplicationController

  layout 'admin'

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({name: 'Default Page'})
    @page_count = Page.count + 1
    @subjects = Subject.sorted
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
      @page_count = Page.count + 1
      @subjects = Subject.sorted
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subjects = Subject.sorted
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully!"
      redirect_to(page_path(@page))
    else
      @page_count = Page.count
      @subjects = Subject.sorted
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

end
