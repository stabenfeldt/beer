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

  def self.populate_if_empty
    create_beer_objects_from_json_file
  end

  private 
  def self.create_beer_objects_from_json_file
    @areas = read_from_json_file
    puts "Areas are #{@areas.inspect}"
    @areas.each do |area|
      area['venues'].each do |place|
        Beer.create(
          name:      place['name'],
          sun_to:    place['sun_to'],
          sun_from:  place['sun_from'],
          url:       place['url'],
          :location => {latitude: place['latitude'], longitude: place['longitude']},
        )
      end
    end
  end

  def self.read_from_json_file 
    #Dispatch::Queue.concurrent('mc-data').async {
      areas_string = File.read("#{App.resources_path}/areas.json")
      @areas = BW::JSON.parse areas_string
    #}
    @areas
  end
  
end
