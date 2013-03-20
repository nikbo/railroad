class Road
  def look
    list
    p_choice=nil
    puts "What do you want to look?"
    p_choice=gets.chomp
    if p_choice=="stations" || p_choice=="station" || p_choice=="Stations" || p_choice=="Station" || p_choice=="STATION" || p_choice=="STATIONS"
      p DB.execute("SELECT * FROM stations;")
    elsif p_choice=="name" || p_choice=="names" || p_choice=="NAME" || p_choice=="NAMES"
      puts "Insert name"
      name_p=nil
      name_p=gets.chomp
      p DB.execute("SELECT * FROM contacts WHERE name='#{name_p}';")
    else p DB.execute("SELECT * FROM contacts;")
    end
  end

  def list
    p lines=DB.execute("SELECT * FROM lines")
    lines.map do|el|
       p el['id'].to_s+" "+el['name']
    end
  end

  def add
    table_choice=nil
    list
    puts "Where you want to add"
    table_choice=gets.chomp
    if table_choice=="lines" || table_choice=="line"
      puts "Insert name of line"
      line_choice=nil
      line_choice=gets.chomp
      DB.execute("insert into lines (name) values ('#{line_choice}');")
      puts "Line added!"
    elsif table_choice=="stations" || table_choice=="station"
      table_choice="stations"
      puts "Insert name of station"
      station_name=nil
      station_id=nil
      station_name=gets.chomp
      puts "Insert id of line for this station"
      station_id=gets.chomp
      station_id=station_id.to_i
      DB.execute("insert into stations (name, line_id) values ('#{station_name}', #{station_id});")
      puts "Station added!"
    else
      pust "Wrong choice!!!"
      exit
    end

  end
end