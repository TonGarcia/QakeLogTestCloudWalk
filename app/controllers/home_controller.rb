require 'csv'

class HomeController < ApplicationController
  # POST /api/importer -> import the received file 
  def importer; end

  # GET /api/report -> generate the expected report
  def report
    render json: Report.generate
  end

  # GET /api/exporter -> retrieve CSV dataset
  def exporter
    @kills = Kill.all
    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = 'attachment; filename=qake_logs.csv'
        render template: 'home/exporter'
      end
    end
  end
end
