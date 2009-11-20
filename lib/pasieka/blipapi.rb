class BlipApi

  def self.start
    Thread.new do

      last_id = nil
      
      while true do
        begin

          Miodek.get_messages(0, last_id).each do |msg|
            Pasieka.parse_message msg
          end

          Pasieka.save_typos

          last_id = Typo.all(:order => [ :blip_id.asc ], :limit => 1).first.blip_id

        rescue Exception => e
          last_id = nil
          $stdout.puts e
        end

        self.wait(300)
      end

    end
  end

  def self.wait(duration)
    begin_time = Time.now

    while (Time.now - begin_time) < duration
      sleep 0.1
    end
  end

end
