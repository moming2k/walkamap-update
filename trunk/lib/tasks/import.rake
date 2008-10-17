namespace 'db' do
  
  namespace 'import' do
    desc "import from csv"
    task :csv => :environment do 
      file = open("#{RAILS_ROOT}/0921.csv")  
      lines = file.read
      CSV.parse(lines).each { |m_item|
        ["8975", "22.502447", "114.128337", nil, "è¥¿é¤å»³", "ç¾åè", "éæå ±å", "ä¸æ°´ä¸æ°´å»£å ´4æ¨å¤§å A", nil]
        item = Item.new
        item["originalid"] = m_item[0] 
        item["lat"] = m_item[1] 
        item["lng"] = m_item[2] 
        item["food_type"] = m_item[4] 
        item["food_country"] = m_item[5] 
        item["name"] = m_item[6] 
        item["address"] = m_item[7] 
        item.save
      }
    end
    
    desc "import from csv"
    task :csv_fon => :environment do 
      file = open("#{RAILS_ROOT}/fon.csv")  
      lines = file.read
      CSV.parse(lines).each { |m_item|
        # p m_item.inspect
        p m_item[4]
        begin
          lat , lng = m_item[4].match(/&amp;ll=(.*?)&amp/)[1].split(",")
          p "#{lat} , #{lng}"
          p m_item[0] 
          p Item.count(:all,:conditions=> ["lat =? and lng = ?",lat , lng] )
          if (Item.count(:all,:conditions=> ["lat =? and lng = ?",lat , lng] ) == 0)  
            item = Item.new
            item["lat"] = lat
            item["lng"] = lng
            item["food_type"] = m_item[2] 
            item["food_country"] = m_item[2] 
            item["name"] = m_item[0] 
            item["address"] = m_item[1] 
            if (Region.find_by_name(m_item[3]))
              item["region_id"] = Region.find_by_name(m_item[3]).id
            end
            item["region_name"] = m_item[3] 
            item["is_fon"] = 1
            item["type_id"] = 7
            item["tel"] = ""
            p item.inspect
            item.save
          else
            p "already exist"
          end
        rescue Exception =>e
          p e.message
        end
        # item.save
      }
    end

  
    desc "import from csv"
    task :region => :environment do 
      Region.find(:all).each { |region|
        Item.find(:all , :conditions => "address Like '#{region.name}%'").each { |item|
          p item.region_name = region.name
          p item.region_id = region.id
          item.save
        }
      }
    end
    
    desc "correct region name"
    task :correct_region_name => :environment do 
      p Item.find(:all , :conditions => ["address Like '側魚%%'  "] ).size
      Item.find(:all , :conditions => ["address Like '側魚%%'  "] ).each { |item|
        item.address = item.address.gsub(/側魚/,"鰂魚")
        item.region_name = "鰂魚涌"
        item.save!
        item.reload
        p item.inspect
      }
    end
    
    def food_type(input)
      case input
      when "港式"
        return 1
      when "廣東菜","上海菜","台灣菜","京川滬","四川菜","潮州菜","客家菜","北京菜","蒙古","雲南菜","杭州菜"
        return 2
      when "日本菜"
        return 3
      when "韓國菜"
        return 4
      when "泰國菜"
        return 5
      when "印度菜"
        return 6
      when "西式"
        return 8
      when "美國菜"
        return 9
      when "法國菜"
        return 10
      when "多國"
        return 11
      else
        return 7
      end
    end
    
    desc "import from csv"
    task :food_type => :environment do 
      Item.find(:all).each { |item|
        item.type_id = food_type(item.food_country) 
        p item.type_id
        item.save
      }
     
    end
    
    desc "export plist of regions"
    task :region_list => :environment do 
      a = File.open("temp_region_list.txt","w")
      (1..3).each { |i|
        a.write "<key>HongKong</key>\n"
        a.write "	<array>\n"
        Region.find(:all , :conditions => "location = #{i} ", :order =>"location ,order_no DESC").each { |region|
          a.write  "  <dict>\n"
          a.write  "			<key>id</key>\n"
          a.write  "			<string>#{region.id}</string>\n"
          a.write  "			<key>name</key>\n"
          a.write  "			<string>#{region.name}</string>\n"
          a.write  "  </dict>\n"
        }
       a.write  " </array>\n"
      }
      a.close
    end
    
    def remove_space(input)
      input.gsub(/ /, "") 
    end
    
    def remove_line(input)
      input.gsub(/-/, "") 
    end
    
    def pattern_match(input, pattern)
    result = ""
    input.scan(pattern) { |matched|
      # p matched[0]
      result = remove_line(remove_space(matched[0]))
      # p result 
    }
      case result.upcase
      when "NIL", "TBC" ,"TBA"
        p "raise"
        raise
      end
      result
    rescue
      ""
    end
    
    desc "re-extract of the tel number"
    task :tel_no => :environment do
      count = 0
      Item.find(:all).each { |item| #,:conditions => "originalid = 13742"
        count += 1
        
        lines = File.open("../decode/#{item.originalid}.htm").readlines.join("")
 
        tel = pattern_match(lines,/<b>電話 :<\/b>(.*)<br \/>/)
        # p tel
        # p lines
        # p tel
        item.tel = tel
        begin
          item.save
        rescue
          sleep 5
          begin
            item.save
          rescue
            p count
            p item.tel
          end
        end
      }
    end
  end
end