require 'nokogiri'
require 'open-uri'

class ScrapperBtc

  $base_url = "https://coinmarketcap.com/"
  $url_rpath = "all/views/all/"

  def perform(recherche)
    scrap_crypto_coins("all/views/all/")
  end

  def scrapper_for_dummies(url, path)
    page = Nokogiri::HTML(open(url))
    return page.css(path)
  end


  def scrap_crypto_coins_every(delay = 3600)
    while true
      puts "[INFOS] sleeping #{delay}s before next request"
      p scrap_crypto_coins("all/views/all/", "https://coinmarketcap.com/")
      sleep delay
    end
  end

  def scrap_crypto_coins(url_rpath, url_base = $base_url)
      url = url_base + url_rpath
    infos = Hash.new
      coins = scrapper_for_dummies(url, ".table-responsive table > tbody > tr")
    coins.each do |coin|
      # coins[0..10].each do |coin| #XXX: pour éviter d'être "noyer" par l'affichage de toutes les valeurs
        coin_symbol = coin.children[5].text
        infos[coin_symbol] = {
          name: coin.children[3].text.gsub!(/[[:space:]]/, '').gsub!(coin_symbol, ''),
          market_cap: coin.children[7].text.strip,
          price: coin.children[9].text.strip,
          circulating: coin.children[11].text.gsub!(/[[:space:]]/, ''),
          volume: coin.children[13].text.strip,
          evol_1h: coin.children[15].text.strip,
          evol_24h: coin.children[17].text.strip,
          evol_7d: coin.children[19].text.strip,
        }
        # infos[coin_symbol][:name] = coin_symbol if infos[coin_symbol][:name].length == 0 # needed sometimes, ex.: NEO case
          # puts "[INFOS] #{coin_symbol} (#{infos[coin_symbol][:name]}): '#{infos[coin_symbol][:price]}'"
    end
    return infos
  end
end
