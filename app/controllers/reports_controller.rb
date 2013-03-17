class ReportsController < ApplicationController

  def show
    render template: "reports/#{params[:id]}"
  end
end
