class ProteinsController < ApplicationController
  # GET /proteins
  # GET /proteins.xml
  def index
    @proteins = Protein.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proteins }
      format.json { render :json => @proteins }
    end
  end

  # GET /proteins/1
  # GET /proteins/1.xml
  def show
    @protein = Protein.from_param(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @protein }
    end
  end

end
