class ProteinsController < ApplicationController
  # GET /proteins
  # GET /proteins.xml
  def index
    f = from
    s = Protein.per_page
    @proteins = Protein.search do
      query do
        string "*"
      end

      from f
      size s
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /proteins/search
  def search
    q = params[:q]
    f = from
    s = Protein.per_page

    @proteins = Protein.search do
      query do
        string q
      end

      from f
      size s
    end
    puts (@proteins.methods - Object.methods).sort

    render :action => "index"
  end

  def from
    @from = Protein.per_page * (page - 1)
  end

  def page
    @page = params.has_key?(:page) ? params[:page].to_i : 1
  end

  # GET /proteins/1
  # GET /proteins/1.xml
  def show
    @protein = Protein.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @protein }
    end
  end

end
