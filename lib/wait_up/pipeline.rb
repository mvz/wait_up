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

    def pipeline
      @pipeline ||= Gst::Pipeline.new('pipeline').tap do |bin|
        bin.add source
      end
    end

    def source
      @source ||= Gst::ElementFactory.make('filesrc', 'source').tap do |element|
        element.set_property 'location', filename
      end
    end

    def speed_changer
      @speed_changer ||= Gst::ElementFactory.make('pitch', 'speed changer').tap do |element|
        element.set_property 'tempo', tempo
      end
    end
  end
end
