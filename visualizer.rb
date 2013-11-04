# Visualizer

class Visualizer < Processing::App

  # Load minim and import the packages we'll be using
  load_library 'minim'
  import 'ddf.minim'
  import 'ddf.minim.analysis'
  
  def setup
    smooth            # smoother == prettier
    size(1280, 100)   # let's pick a more interesting size
    background 10     # ...and a darker background color
  end
  
  def draw
  end
  
end

Visualizer.new :title => "Visualizer"