class PadawansController < ApplicationController
  # GET /padawans
  # GET /padawans.json
  def index
    @padawans = Padawan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @padawans }
    end
  end

  # GET /padawans/1
  # GET /padawans/1.json
  def show
    @padawan = Padawan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @padawan }
    end
  end

  # GET /padawans/new
  # GET /padawans/new.json
  def new
    @padawan = Padawan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @padawan }
    end
  end

  # GET /padawans/1/edit
  def edit
    @padawan = Padawan.find(params[:id])
  end

  # POST /padawans
  # POST /padawans.json
  def create
    @padawan = Padawan.new(params[:padawan])

    respond_to do |format|
      if @padawan.save
        format.html { redirect_to @padawan, notice: 'Padawan was successfully created.' }
        format.json { render json: @padawan, status: :created, location: @padawan }
      else
        format.html { render action: "new" }
        format.json { render json: @padawan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /padawans/1
  # PUT /padawans/1.json
  def update
    @padawan = Padawan.find(params[:id])

    respond_to do |format|
      if @padawan.update_attributes(params[:padawan])
        format.html { redirect_to @padawan, notice: 'Padawan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @padawan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /padawans/1
  # DELETE /padawans/1.json
  def destroy
    @padawan = Padawan.find(params[:id])
    @padawan.destroy

    respond_to do |format|
      format.html { redirect_to padawans_url }
      format.json { head :no_content }
    end
  end
end
