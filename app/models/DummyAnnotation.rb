class DummyAnnotation
  attr_accessor :title, :latitude, :longitude, :subtitle

  def coordinate
    CLLocationCoordinate2D.new(latitude, longitude)
  end
end
