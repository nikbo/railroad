class Road
  def look
    choice = nil
    until choice == 'e'
      puts "Press 's' to list all stations on the line, 'w' to list all other stations with this station "
      puts "Press 'e' to exit."
      choice = gets.chomp
      case choice
        when 's'
          line
        when 'w'
          station
        when 'e'
          exit
        else
          invalid
      end
    end
  end

  def list
    lines=DB.execute("SELECT * FROM lines")
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
      puts "Wrong choice!!!"
      exit
    end

  end

  def line
    list
    puts "Insert id of line"
    id_choice=nil
    id_choice=gets.chomp
    choice=DB.execute("select stations.name from stations where stations.line_id=#{id_choice};")
    choice.map do|el|
      p el['name']
    end
  end

  def station
    stations=DB.execute("SELECT * FROM stations")
    stations.map do|el|
      p el['id'].to_s+" "+el['name']+el['line_id'].to_s
    end
    puts "Insert id of start station"
    station_choice=nil
    station_choice=gets.chomp
    ch=DB.execute("select line_id from stations where line_id=#{station_choice};")
    s=ch[0]['line_id']
    choice=DB.execute("select * from stations where line_id=#{s};")
    choice.map do|el|
      if el['id']!=el['line_id']
      p el['name']
        end
    end
  end
end