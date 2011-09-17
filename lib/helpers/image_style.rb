module ImageStyle

  def random_style
    rotation = random(-5, 5)

    "width: #{size}px; 
     height: #{size}px; 
     -moz-transform: rotate(#{rotation}deg); 
     -webkit-transform: rotate(#{rotation}deg); 
     -o-transform: rotate(#{rotation}deg); 
     -ms-transform: rotate(#{rotation}deg); 
     transform: rotate(#{rotation}deg);"
  end

  private

  def size
    40 + random(-10, 10)
  end

  def random(min, max)
    rand(max - min) + min
  end

end