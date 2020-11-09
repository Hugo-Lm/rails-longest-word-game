require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end


  def score
    console.log(ActionDispatch::Session::CacheStore)
    @score = 0
    url = "https://wagon-dictionary.herokuapp.com/#{params[:mot]}"
    dico_search = open(url).read
    @word_validation = JSON.parse(dico_search)['found']


    if @word_validation

      letters_of_word = params[:mot].split("")

      letters_of_word.each do |letter|
        if params[:letters].include?(letter.upcase)
          next
        else
          @result = "Sorry but #{params[:mot]} can't be built out of #{params[:letters]}"
          break
        end
      end
      @result = "Congratulations! #{params[:mot]} is a valid english word"
      @score += (params[:mot].length)**2
    else
      @result = "Sorry but #{params[:mot]} dosesn't seems to be an English word..."
    end

    @result

  end
end
