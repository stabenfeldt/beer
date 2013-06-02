class FirstViewController < UITableViewController
   def viewDidLoad
    super
    if Beer.all.size == 0
      create_beer_objects_from_json_file
      view.reloadData
    end
    puts @areas
    #view.dataSource = view.delegate = self
    #@areas = Beer.all
    self.title = "Bydeler"
    return @areas
  end

  def viewWillAppear(animated)
    #navigationController.setNavigationBarHidden(true, animated:true)
    #self.navigationController.pushViewController(self, animated: true)
  end    

  def tableView(tableView, numberOfRowsInSection:section)
    @areas ? @areas.size : 0
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:cellIdentifier)
      cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton
      cell
    end

    area = @areas[indexPath.row]
    cell.textLabel.text = area['name']
    cell
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath:indexPath)
    area = @areas[indexPath.row]
    area_controller = AreaTableViewController.alloc.init
    self.navigationController.pushViewController(area_controller, animated:true)
    area_controller.bind_with_area(area)
  end


  def create_beer_objects_from_json_file
    @areas = read_from_json_file
    puts "Areas are #{@areas.inspect}"
    @areas.each do |area|
      area['venues'].each do |place|
        Beer.create(
          name:      place['name'],
          sun_to:    place['sun_to'],
          sun_from:  place['sun_from'],
          longitude: place['longitude'],
          latitude:  place['latitude'],
          url:       place['latitude']
        )
      end
    end
  end

  def read_from_json_file 
    #Dispatch::Queue.concurrent('mc-data').async {
      areas_string = File.read("#{App.resources_path}/areas.json")
      @areas = BW::JSON.parse areas_string
    #}
    @areas
  end
  
end
