class SecondViewController < UIViewController
  def init
    if super
      self.tabBarItem = UITabBarItem.alloc.initWithTitle('Map', image:UIImage.imageNamed('map.png'), tag:1)
    end
    self
  end

  def loadView
    self.view = MKMapView.alloc.init
    view.delegate = self

    Dispatch::Queue.concurrent('mc-data').async {
      areas_string = File.read("#{App.resources_path}/areas.json")
      @areas = BW::JSON.parse areas_string
      view.reloadData
    }
    self.title = "Map"
    return @areas
  end

  def viewDidLoad
    view.frame = tabBarController.view.bounds

    # Oslo => 59.9494° N, 10.7564° E
    region = MKCoordinateRegionMake(CLLocationCoordinate2D.new(59.911309, 10.751903), MKCoordinateSpanMake(0.04, 0.04))
    self.view.setRegion(region)

    #Beer.places_with_sun_now.each { |beer| self.view.addAnnotation(beer) }
    Beer.places_with_sun_now.each { |beer| self.view.addAnnotation(beer) }
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated:true)
  end    

  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:beer)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = beer
    else
      view = MKPinAnnotationView.alloc.initWithAnnotation(beer, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      view.animatesDrop = true
      button = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
      button.addTarget(self, action: :'showDetails:', forControlEvents:UIControlEventTouchUpInside)
      view.rightCalloutAccessoryView = button
    end
    view
  end

  def showDetails(sender)
    if view.selectedAnnotations.size == 1
      beer = view.selectedAnnotations[0]
      controller = UIApplication.sharedApplication.delegate.beer_details_controller
      navigationController.pushViewController(controller, animated:true)
      controller.showDetailsForBeer(beer)
    end
  end
end
