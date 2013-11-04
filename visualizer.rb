# Visualizer

class Visualizer < Processing::App

  # Load minim and import the packages we'll be using
  load_library 'minim'
  import 'ddf.minim'
  import 'ddf.minim.analysis'

  def setup_sound
    # Creates a Minim object
    @minim = Minim.new(self)
    # Lets Minim grad sound data from mic/soundflower

    @input = @minim.get_line_in

    # Gets FFT values from sound data
    @fft = FFT.new(@input.left.size, 44100)
    # Our beat detector object

    @beat = BeatDetect.new

    # Set an array of frequencies we'd like to get FFT data for
    # -- These numbers are grabbed VLC's equalizer
    @freqs = [60, 170, 310, 600, 1000, 3000, 6000, 12000, 14000, 16000]

    # Create arrays to store the current FFT values,

    # previous FFT values, highest FFT values we've seen,
    # and scaled/normalized FFT values (which are easier to work with)
    @current_ffts   = Array.new(@freqs.size, 0.001)
    @previous_ffts  = Array.new(@freqs.size, 0.001)
    @max_ffts       = Array.new(@freqs.size, 0.001)
    @scaled_ffts    = Array.new(@freqs.size, 0.001)

    # We'll use this value to adjust the "smoothness" factor

    # of our sound responsiveness
    @fft_something = 0.8
  end

  def setup
    smooth            # smoother == prettier
    size(1280, 100)   # let's pick a more interesting size
    background 10     # ...and a darker background color
    setup_sound
  end
  
  def draw
  end
  
end

Visualizer.new :title => "Visualizer"