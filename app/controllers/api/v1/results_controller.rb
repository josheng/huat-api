require 'date'

class Api::V1::ResultsController < ApplicationController
  def fourdlatestresult
    # return latest result
    render json: Fourd.first
  end

  def fourddatedresult
    # return specific result based on date
    date = JSON.parse(params[:drawdate].to_json)
    number = JSON.parse(params[:number].to_json) if params[:number]
    parseddate = Date.parse(date).strftime('%d %b %Y')
    result = Fourd.find_by(drawdate: parseddate).as_json
    if result
      render json: result.merge(checkresult(number, result))
    else
      render json: { message: 'no result found!' }
    end
  end

  def fourdgetdate
    # return all the dates of the draws
    render json: Fourd.pluck(:drawdate)
  end

  def checkresult(number, result)
    matched = []
    number.each do |num|
      matched << "first: #{num}" if result['first'] == num
      matched << "second: #{num}" if result['second'] == num
      matched << "third: #{num}" if result['third'] == num
      matched << "starter: #{num}" if result['starter'].include?(num)
      matched << "consolation: #{num}" if result['consolation'].include?(num)
    end
    { winningnumber: matched }
  end
end
