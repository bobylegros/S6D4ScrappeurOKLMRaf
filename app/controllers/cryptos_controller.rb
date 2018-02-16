class CryptosController < ApplicationController
  def home
    crypto = params.permit(:recherche)
    @infos = ScrapperBtc.new.perform(crypto[:recherche])
  end

  def search
    @crypto = params.permit(:recherche)
    @infos = ScrapperBtc.new.perform(@crypto[:recherche])
  end
end
