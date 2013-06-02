class Beer
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  
  columns location: :hash,
          name:     :string,
          url:      :string,
          sun_from: :date,
          sun_to:   :date
  

  def title;      name;       end
  def url;        url;        end

  def coordinate
    loc           = CLLocationCoordinate2D.new
    loc.latitude  = location[:latitude]
    loc.longitude = location[:longitude]
    loc
  end

  def has_sun_now?
    (sun_from..sun_to).cover? Time.now
  end

  def self.places_with_sun_now
    Beer.all.select { |b| b.has_sun_now? }
  end

end
