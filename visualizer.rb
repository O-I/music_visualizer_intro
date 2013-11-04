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
    @fft_smoothing = 0.8
  end

  def update_sound
    @fft.forward(@input.left)

    @previous_ffts = @current_ffts

    # Iterate over the frequencies of interest and get FFT values
    @freqs.each_with_index do |freq, i|
      # The FFT value for this frequency
      new_fft = @fft.get_freq(freq)

      # Set it as the frequency max if it's larger than the previous max

      @max_ffts[i] = new_fft if new_fft > @max_ffts[i]

      # Use our "smoothness" factor and the previous FFT
      # to set a current FFT value
      @current_ffts[i] = ((1 - @fft_smoothing)) * new_fft) + (@fft_smoothing * @previous_ffts[i])

      # Set a scaled/normalized FFT value that will be
      # easeir to work with for this frequency
      @scaled_ffts[i] = @current_ffts[i]/@max_ffts[i]
    end

    #Check if there's a beat, will be stored in @beat.is_onset
    @beat.detect(@input.left)
  end

  def setup
    smooth            # smoother == prettier
    size(1280, 100)   # let's pick a more interesting size
    background 10     # ...and a darker background color
    setup_sound
  end
  
  def draw
    update_sound
  end
  
end

Visualizer.new :title => "Visualizer"