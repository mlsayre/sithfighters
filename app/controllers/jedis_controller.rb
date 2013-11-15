class JedisController < ApplicationController
  # GET /jedis
  # GET /jedis.json
  def index
    @jedis = Jedi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jedis }
    end
  end

  # GET /jedis/1
  # GET /jedis/1.json
  def show
    @jedi = Jedi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jedi }
    end
  end

  # GET /jedis/new
  # GET /jedis/new.json
  def new
    @jedi = Jedi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jedi }
    end
  end

  # GET /jedis/1/edit
  def edit
    @jedi = Jedi.find(params[:id])
  end

  # POST /jedis
  # POST /jedis.json
  def create
    @jedi = Jedi.new(params[:jedi])

    respond_to do |format|
      if @jedi.save
        format.html { redirect_to @jedi, notice: 'Jedi was successfully created.' }
        format.json { render json: @jedi, status: :created, location: @jedi }
      else
        format.html { render action: "new" }
        format.json { render json: @jedi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jedis/1
  # PUT /jedis/1.json
  def update
    @jedi = Jedi.find(params[:id])

    respond_to do |format|
      if @jedi.update_attributes(params[:jedi])
        format.html { redirect_to @jedi, notice: 'Jedi was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jedi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jedis/1
  # DELETE /jedis/1.json
  def destroy
    @jedi = Jedi.find(params[:id])
    @jedi.destroy

    respond_to do |format|
      format.html { redirect_to jedis_url }
      format.json { head :no_content }
    end
  end
end
