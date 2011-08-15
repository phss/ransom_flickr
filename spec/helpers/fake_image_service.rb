class FakeImageService

  def initialize(images_hash)
    @images_hash = images_hash
  end

  def browse(character)
    @images_hash.find_all { |image| image[:Letter] == character }.collect { |image| image[:Image] }
  end

end