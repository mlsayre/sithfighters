class ApprenticeshipsController < ApplicationController
  # GET /apprenticeships
  # GET /apprenticeships.json
  def index
    @apprenticeships = Apprenticeship.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apprenticeships }
    end
  end

  # GET /apprenticeships/1
  # GET /apprenticeships/1.json
  def show
    @apprenticeship = Apprenticeship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @apprenticeship }
    end
  end

  # GET /apprenticeships/new
  # GET /apprenticeships/new.json
  def new
    @apprenticeship = Apprenticeship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @apprenticeship }
    end
  end

  # GET /apprenticeships/1/edit
  def edit
    @apprenticeship = Apprenticeship.find(params[:id])
  end

  # POST /apprenticeships
  # POST /apprenticeships.json
  def create
    @apprenticeship = Apprenticeship.new(params[:apprenticeship])

    respond_to do |format|
      if @apprenticeship.save
        format.html { redirect_to @apprenticeship, notice: 'Apprenticeship was successfully created.' }
        format.json { render json: @apprenticeship, status: :created, location: @apprenticeship }
      else
        format.html { render action: "new" }
        format.json { render json: @apprenticeship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apprenticeships/1
  # PUT /apprenticeships/1.json
  def update
    @apprenticeship = Apprenticeship.find(params[:id])

    respond_to do |format|
      if @apprenticeship.update_attributes(params[:apprenticeship])
        format.html { redirect_to @apprenticeship, notice: 'Apprenticeship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @apprenticeship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apprenticeships/1
  # DELETE /apprenticeships/1.json
  def destroy
    @apprenticeship = Apprenticeship.find(params[:id])
    @apprenticeship.destroy

    respond_to do |format|
      format.html { redirect_to apprenticeships_url }
      format.json { head :no_content }
    end
  end
end
