require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @new = []
    @new << ['A', 'E', 'I', 'O', 'U'].sample
    9.times do
      @new << ('A'..'Z').to_a.sample
    end
    @new.shuffle!
  end

  def score
    # word cannot be made by the grid
    letters = params[:letters].split(' ')
    guess = params[:guess].upcase.split('')
    guess.each do |letter|
      return @message = "#{params[:guess]} cannot be made from #{params[:letters]}" if letters.find_index(letter).nil?

      id = letters.find_index(letter)
      letters.delete_at(id)
    end
    base_url = 'https://wagon-dictionary.herokuapp.com/'
    url = base_url + params[:guess]
    serialized = open(url).read
    check = JSON.parse(serialized)
    if check['found']
      @score = params[:guess].length * 10
    else
      @score = 0
    end
  end
end
