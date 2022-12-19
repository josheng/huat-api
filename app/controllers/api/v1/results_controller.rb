require 'date'

class Api::V1::ResultsController < ApplicationController
  def fourdresult
    # return specific result based on date if params is provided
    date = JSON.parse(params[:drawdate])
    if date
      parseddate = Date.parse(date).strftime('%d %b %Y')
      render json: Fourd.find_by(drawdate: parseddate)
    else
      render json: Fourd.all
    end
  end
end
