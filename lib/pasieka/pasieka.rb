class Pasieka
  attr_accessor :typos

  def initialize
    @typos = []
  end
  
  # Metoda ta parsuje wiadomość z Blipa uprzednio przeparsowną
  # przez parser JSON, otrzymuje więc obiekty typu Hash
  #
  # Format message['body']:
  # <dowolny tekst> niepoprawnda forma -> poprawna forma
  # gdzie:
  #  - niepoprawna forma składa się wyłącznie z jednego wyrazu
  #  - w jednej wiadomości może występować kilka poprawek
  def parse_message(message)
    message['body'].reverse.gsub(/([^\">]*)\s>-\s([\wĄĘŻŹĆÓŁŃŚąężźćółńś]*){1}[^\w]?/) do
      # $2 - niepoprawna forma (może składać się z kilku członów)
      # $1 - poprawna forma
      typos.push({:typo => $2.reverse.downcase, :correct_form => $1.reverse.downcase, :blip_id => message['id']})
    end
  end

  def save_typos
    typos.each do |typo|
      Typo.new(:typo => typo[:typo], :correct_form => typo[:correct_form], :blip_id => typo[:blip_id]).save
    end
    
  end

end
