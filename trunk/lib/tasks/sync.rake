require "uuid"

namespace 'sync' do
  
  desc "sync sqlitedb to mysql"
  task :lite_to_mysql => :environment do
    class MyItem < ActiveRecord::Base
       establish_connection :mysql
       set_table_name "items"
    end

    class LiteItem < ActiveRecord::Base
       establish_connection :sqlite
       set_table_name "items"
    end
    
    p "sync to mysql"
    LiteItem.find(:all).each { |item|
      temp_item = MyItem.find_or_create_by_uuid(item.uuid)
      temp_item.attributes = item.attributes
      temp_item.save
    }
  end
  
  task :mysql_to_lite => :environment do
    class MyItem < ActiveRecord::Base
       establish_connection :mysql
       set_table_name "items"
    end

    class LiteItem < ActiveRecord::Base
       establish_connection :sqlite
       set_table_name "items"
    end
    
    p "sync to sqlite"
    LiteItem.find(:all).each { |item|
      temp_item = MyItem.find_or_create_by_uuid(item.uuid)
      temp_item.attributes = item.attributes
      temp_item.save
    }
  end
  
  

end