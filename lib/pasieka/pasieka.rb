class Pasieka
  attr_accessor :typos

  def initialize
    @typos = []
  end
  
  # Format wiadomości:
  # <dowolny tekst> niepoprawnda forma -> poprawna forma
  # gdzie:
  #  - niepoprawna forma składa się wyłącznie z jednego wyrazu
  #  - w jednej wiadomości może występować kilka poprawek
  def parse_message(message)
    message.reverse.gsub(/([^\">]*)\s>-\s([\w]*){1}[^\w]?/) do
      # $2 - niepoprawna forma (może składać się z kilku członów)
      # $1 - poprawna forma
      typos.push({$2.reverse.downcase => $1.reverse.downcase})
    end
  end

end
