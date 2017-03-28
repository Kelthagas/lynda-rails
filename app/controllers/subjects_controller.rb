class SubjectsController < ApplicationController

  layout 'admin'

  def index
    logger.debug("*** Testing the logger ***")
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({name: 'Default'})
    @subject_count = Subject.count + 1
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
      # Flash Hash
      flash[:notice] = "Subject created successfully!"
      # If save succeeds, redirect to the index action
      redirect_to(subjects_path)
    else
      # If the save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    # Find a new object using form parameters
    @subject = Subject.find(params[:id])
    # Save the object
    if @subject.update_attributes(subject_params)
      # If save succeeds, redirect to the index action
      flash[:notice] = "Subject updated successfully!"
      redirect_to(subject_path(@subject))
    else
      # If the save fails, redisplay the form so user can fix problems
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' deleted successfully!"
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end

end
