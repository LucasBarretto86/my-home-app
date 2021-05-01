require 'faker'

# Define local temp images path
path = Rails.root.join('test/fixtures/files')

# iterate 50 times, each time instantiate properties variable,
# set a Random Street name as name, then iterate through the path directory to
# reach mocked pictures, do set it to shuffle it and attache to the photos collection

50.times do
  property = Property.new(name: Faker::Address.street_name)

  Dir.children(path).shuffle.each do |file|
    property.photos.attach(io: File.open([path, file].join('/')), filename: file)
    property.save!
  end
end