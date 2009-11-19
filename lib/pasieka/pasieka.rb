class Pasieka
  @@typos = []

  class << self

    def typos
      @@typos
    end

    def typos=(data)
      @@typos = data
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

    def save_typos(clear_typos_after_save = true)

      typos.each do |typo|

        new_typo = Typo.new(:typo => typo[:typo], :correct_form => typo[:correct_form], :blip_id => typo[:blip_id])

        if new_typo.save
          TypoCounter.bump_or_create :typo => new_typo.typo, :correct_form => new_typo.correct_form
        end
      end

      typos.clear if clear_typos_after_save

    end

  end

end
