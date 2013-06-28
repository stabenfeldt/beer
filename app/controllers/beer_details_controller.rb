class BeerDetailsController < UIViewController
  def loadView
    self.view = UIWebView.alloc.init
  end

  def viewWillAppear(animated)
    navigationController.setNavigationBarHidden(false, animated:true)
  end

  def showDetailsForBeer(beer)
    navigationItem.title = beer.title
    nsurl   = NSURL.URLWithString(beer.url)
    request = NSURLRequest.requestWithURL(nsurl)
    view.loadRequest(request)
  end 
end
