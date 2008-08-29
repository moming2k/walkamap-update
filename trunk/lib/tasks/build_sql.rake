namespace 'db' do
  desc 'build name from file'
  task :build_items => :environment do
    Dir.glob("../pure/*.txt").each { |name|
      p "filename = #{name}"
      File.open(name) {|file|
        begin
          line1 = file.readline
          item = Item.new
          item.name = line1.strip
          line = file.read
          lines = line.split("\n")
          lines.each { |elem|
            key , value = elem.split(":")
            begin
              case key
              when "address"
                item.address = value.strip
              when "tel"
                item.tel = value.strip
              when "lat"
                item.lat = value.strip
              when "long"
                item.lng = value.strip
              end
            rescue
            end
          }
          p item.inspect
          item.save
        rescue
        end
      } 
    }
  end
  
  desc 'build name from file'
  task :batch_update => :environment do
    Item.find(:all).each { |item|
      begin
        p "id = #{item.id}"
        p item.tel
        item.tel = item.tel.gsub(/-/,"")
        p item.tel
        item.save!
      rescue Exception => e
        p e.message
      end
    }
  end
  
  desc 'remove to be confirm of tel'
  task :batch_update2 => :environment do
    Item.find(:all).each { |item|
      begin
        p "#{id} - #{item.tel}"
        case item.tel.upcase
        when "NIL","TBC","TCB","TBA"
          item.tel = ""
        end
        p "#{id} - #{item.tel}"
        item.save!
      rescue Exception => e
        p e.message
      end
    }
  end
end