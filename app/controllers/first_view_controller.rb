class FirstViewController < UITableViewController
   def viewDidLoad
    super
    @areas = Beer.populate_if_empty
    view.reloadData
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


end
