require 'gir_ffi'

GirFFI.setup :Gst

module WaitUp
  # Wait Up pipeline class
  class Pipeline
    attr_reader :filename, :tempo

    def initialize(filename, tempo)
      @filename = filename
      @tempo = tempo
    end

    def play
      puts "Playing #{filename} at tempo #{tempo}"
    end
  end
end
