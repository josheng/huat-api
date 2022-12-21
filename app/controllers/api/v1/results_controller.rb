require 'date'

class Api::V1::ResultsController < ApplicationController
  def fourdlatestresult
    # return latest result
    render json: Fourd.first
  end

  def fourddatedresult
    # return specific result based on date
    date = JSON.parse(params[:drawdate].to_json)
    parseddate = Date.parse(date).strftime('%d %b %Y')
    result = Fourd.find_by(drawdate: parseddate)
    if result
      render json: result
    else
      render json: { message: 'no result found!' }
    end
  end

  def fourdgetdate
    # return all the dates of the draws
    render json: Fourd.pluck(:drawdate)
  end
end
