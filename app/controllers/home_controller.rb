class HomeController < ApplicationController
  # POST /api/importer -> import the received file 
  def importer
  end

  # GET /api/report -> generate the expected report
  def report
    render json: Report.generate
  end

  # GET /api/exporter -> retrieve CSV dataset
  def exporter
  end
end
