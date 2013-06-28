class VenueDetailsController < UIViewController
  def loadView
    self.view = UIWebView.alloc.init
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(false, animated:true)
  end

  def showDetailsForVenue(venue)
    navigationItem.title = venue.title
    nsurl   = NSURL.URLWithString(venue.url)
    request = NSURLRequest.requestWithURL(nsurl)
    view.loadRequest(request)
  end 
end
