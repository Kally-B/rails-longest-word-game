require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []

    10.times do |letter|
      letter = ('a'..'z').to_a.sample
      @letters << letter
    end
  end

  def score
    # if each letter of word is included, check if English word
    @result = ""
    @word_letters = params[:word].upcase.split("")
    @sample_letters = params[:sample].upcase.split("")

    check_letters = @word_letters.all? do |letter|
      @word_letters.include?(letter) && @word_letters.count(letter) <= @sample_letters.count(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary = JSON.parse(open(url).read)

    if check_letters == false
      @result = "Sorry but #{params[:word].upcase} can't be built out of #{@word_letters.join(", ")}"
    elsif dictionary["found"] == false
      @result = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulation! #{params[:word].upcase} is a valid Enflish word!"
    end
  end
end
