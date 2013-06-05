class Beer
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  attr_accessor :dummy_annotation
  
  columns location: :hash,
          name:     :string,
          address:  :string,
          url:      :string,
          open_from: :date,
          open_to:   :date
  

  def title;      name;       end
  def url;        url;        end

  def coordinate
    CLLocationCoordinate2D.new(location[:latitude], location[:longitude])
  end

  def store_open?
    (open_from..open_to).cover? Time.now
  end

  def self.open_now
    Beer.all.select { |b| b.store_open? }
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
          address:   place['address'],
          open_to:   place['open_to'],
          open_from: place['open_from'],
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
