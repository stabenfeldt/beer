class AreaListController  < UITableViewController
  def initWithNibName(name, bundle: bundle)
    super
    self.tabBarItem =
      UITabBarItem.alloc.initWithTitle(
        "Areas",
        image:UIImage.imageNamed('list.png'),
        tag: 1)
    self
  end

  
  

  def viewDidLoad
    super
    @areas = Beer.populate_if_empty
    view.reloadData
    return @areas
  end

  def viewWillAppear( animated ) 
    navigationController.setNavigationBarHidden( false, animated: true ) 
    true 
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
    venue_list_controller = VenueListController.alloc.init
    self.navigationController.pushViewController(venue_list_controller, animated:true)
    venue_list_controller.bind_with_area(area)
  end


end
