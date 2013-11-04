# Visualizer

class Visualizer < Processing::App

  def setup
    smooth            # smoother == prettier
    size(1280, 100)   # let's pick a more interesting size
    background 10     # ...and a darker background color
  end
  
  def draw
  end
  
end

Visualizer.new :title => "Visualizer"