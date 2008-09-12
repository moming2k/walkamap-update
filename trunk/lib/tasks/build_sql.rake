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
  
  desc 'calculate the region and subregion'
  task :batch_update3 => :environment do
    Item.find(:all).each { |item|
      begin
        region_name = item.address.chars[0,3]
        region = Region.find_or_create_by_name(region_name)
        if (region.new_record?)
          region.lat = item.lat
          region.lng = item.lng
          region.save
        end
      rescue Exception => e
        p e.message
      end
    }
  end
  
  desc 'calculate the region'
  task :batch_update4 => :environment do
    Region.find(:all).each { |item|
      begin
        region_name = item.name.chars[0,2]
        regions = Region.find(:all , :conditions => ["name Like ?","#{region_name}%"])
        if regions.size > 1 
          regions.each { |region|
            region.destroy
          }
          region = Region.find_or_create_by_name(region_name)
        end
      rescue Exception => e
        p e.message
      end
    }
  end
  
  desc 'calculate the subregion'
  task :batch_update5 => :environment do
    Item.find(:all).each { |item|
      begin
        ["廣場","中心","大樓","酒店","中心","大廈","坊","商場"].each { |name|
          temp_name = ""
          10.times { |i|
            sub_region_name = item.address.chars[0,3+i]
            item_sub_region = Item.find(:all , :conditions => ["address Like ? and address Like ?","#{sub_region_name}%","%#{name}%"])
            if item_sub_region.size > 4
              temp_name = sub_region_name
            else
              break
            end
          }
          SubRegion.find_or_create_by_name(temp_name) if  !temp_name.blank? and (temp_name.size > 3)
        }
      rescue Exception => e
        p e.message
      end
    }
  end
  
  desc 'calculate the subregion'
  task :batch_update6 => :environment do
    Item.find(:all).each { |item|
      begin
        ["廣場","中心","大樓","酒店","中心","大廈","坊","商場"].each { |name|
          temp_name = ""
          item_sub_region = Item.find(:all , :conditions => ["address Like ?","%#{name}%"])
          item_sub_region.each { |region_name|
            SubRegion.find_or_create_by_name(region_name.address)
          }
        }
      rescue Exception => e
        p e.message
      end
    }
  end
  
  desc 'calculate the subregion to repeat dup record'
  task :batch_update7 => :environment do
    while true do
      deleted = false
      SubRegion2.find(:all , :order => "name").each { |item|
        item2_s = SubRegion2.find(:all, :conditions => ["name Like ? ","#{item.name}%"])
        if item2_s.size > 1
          item2_s.each { |item2|
            item2.destroy
            deleted = true
          }
          p "break at #{item.id}"
          SubRegion2.create(:name => item.name)
          break
        end
      }
      break unless deleted
    end
  end
  
  desc 'calculate the subregion to repeat dup record'
  task :batch_update8 => :environment do
    while true do
      deleted = false
      file = File.open("result_8.html","w")
      SubRegion2.find(:all , :order => "name").each { |item|
        p item.name
        file.write(item.name+"\r\n\r")
        item.name.gsub!(/廣場/,'廣場|')
        item.name.gsub!(/中心/,'中心|')
        item.name.gsub!(/大樓/,'大樓|')
        item.name.gsub!(/酒店/,'酒店|')
        item.name.gsub!(/中心/,'中心|')
        item.name.gsub!(/大廈/,'大廈|')
        item.name.gsub!(/坊/,'坊|')
        item.name.gsub!(/商場/,'商場|')
        item.save
      }
      file.close
      break unless deleted
    end
  end
end