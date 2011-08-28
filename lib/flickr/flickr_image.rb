class FlickrImage

  attr_reader :image_id, :url

  def initialize(image_id, url)
    @image_id, @url = image_id, url
  end

end