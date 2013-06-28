class MapController < UIViewController
  def init
    if super
      self.tabBarItem = UITabBarItem.alloc.initWithTitle('Uteservering med sol nå', image:UIImage.imageNamed('map.png'), tag:1)
    end
    self
  end

  def loadView
    self.view     = MKMapView.alloc.init
    view.delegate = self
    @areas      ||= Venue.populate_if_empty
    self.title    = "Uteservering med sol nå"
    return @areas
  end

  def viewDidLoad
    view.frame = tabBarController.view.bounds
    region = MKCoordinateRegionMake(CLLocationCoordinate2D.new(59.911309, 10.751903), MKCoordinateSpanMake(0.04, 0.04))
    self.view.setRegion(region)
    Venue.sun_now.each do |venue| 
      shadow                = DummyAnnotation.new
      shadow.title          = venue.title
      shadow.url            = venue.url 
      shadow.longitude      = venue.location[:longitude]
      shadow.latitude       = venue.location[:latitude]
      shadow.subtitle       = "Sol #{venue.sun_from.strftime '%H:%M'} - #{venue.sun_to.strftime '%H:%M'}" +
                              "  " + venue.address
      venue.dummy_annotation = shadow
      self.view.addAnnotation(venue.dummy_annotation)
    end
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(true, animated:true)
  end    

  ViewIdentifier = 'ViewIdentifier'
  def mapView(mapView, viewForAnnotation:venue)
    if view = mapView.dequeueReusableAnnotationViewWithIdentifier(ViewIdentifier)
      view.annotation = venue
    else
      view                = MKPinAnnotationView.alloc.initWithAnnotation(venue, reuseIdentifier:ViewIdentifier)
      view.canShowCallout = true
      view.animatesDrop   = true
      button              = UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
      button.addTarget(self, action: :'showDetails:', forControlEvents:UIControlEventTouchUpInside)
      view.rightCalloutAccessoryView = button
    end
    view
  end

  def showDetails(sender)
    if view.selectedAnnotations.size == 1
      venue = view.selectedAnnotations[0]
      controller = UIApplication.sharedApplication.delegate.venue_details_controller
      navigationController.pushViewController(controller, animated:true)
      controller.showDetailsForVenue(venue)
    end
  end
end
