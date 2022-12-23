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
    number.each_with_index do |num, ind|
      matched << "first: #{num}, prize: #{prize = calcwinningbet(bet[ind], 'first')}" if result['first'] == num
      matched << "second: #{num}, prize: #{prize = calcwinningbet(bet[ind], 'second')}" if result['second'] == num
      matched << "third: #{num}, prize: #{prize = calcwinningbet(bet[ind], 'third')}" if result['third'] == num
      matched << "starter: #{num}, prize: #{prize = calcwinningbet(bet[ind], 'starter')}" if result['starter'].include?(num)
      matched << "consolation: #{num}, prize: #{prize = calcwinningbet(bet[ind], 'consolation')}" if result['consolation'].include?(num)
      total += prize if prize
    end
    matched = 'no winning number' if matched.empty?
    { winningnumber: matched, totalwinnings: total }
  end

  def calcwinningbet(bet, category)
    total = 0
    prize = { big1: 2000, small1: 3000, big2: 1000, small2: 2000, big3: 490, small3: 800, bigs: 250, bigc: 60 }
    # calculate here
    case category
    when 'first'
      total = (bet['b'] * prize[:big1]) + (bet['s'] * prize[:small1])
    when 'second'
      total = (bet['b'] * prize[:big2]) + (bet['s'] * prize[:small2])
    when 'third'
      total = (bet['b'] * prize[:big3]) + (bet['s'] * prize[:small3])
    when 'starter'
      total = bet['b'] * prize[:bigs]
    when 'consolation'
      total = bet['b'] * prize[:bigc]
    end
    total
  end
end
