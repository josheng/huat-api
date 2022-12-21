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
    bet = JSON.parse(params[:bet].to_json) if params[:bet]
    parseddate = Date.parse(date).strftime('%d %b %Y')
    result = Fourd.find_by(drawdate: parseddate).as_json
    if result && number
      render json: result.merge(checkresult(number, bet, result))
    elsif result
      render json: result
    else
      render json: { message: 'no result found!' }
    end
  end

  def fourdgetdate
    # return all the dates of the draws
    render json: Fourd.pluck(:drawdate)
  end

  def checkresult(number, bet, result)
    matched = []
    total = 0
    number.each do |num|
      matched << "first: #{num}, winning: #{calcwinningbet(bet)}" if result['first'] == num
      matched << "second: #{num}, winning: #{calcwinningbet(bet)}" if result['second'] == num
      matched << "third: #{num}, winning: #{calcwinningbet(bet)}" if result['third'] == num
      matched << "starter: #{num}, winning: #{calcwinningbet(bet)}" if result['starter'].include?(num)
      matched << "consolation: #{num}, winning: #{calcwinningbet(bet)}" if result['consolation'].include?(num)
    end
    { winningnumber: matched, totalwinnings: total }
  end

  def calcwinning(bet)
    prize = { bigfirst: 2000, smallfirst: 3000, bigsecond: 1000, smallsecond: 2000, bigthird: 490, smallthird: 800, bigstarter: 250, bigconsolation: 60}
    # calculate here
  end
end
