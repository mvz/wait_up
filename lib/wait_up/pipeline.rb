require 'gir_ffi'

GirFFI.setup :Gst

module Gst
  load_class :Bin

  class Bin
    def add_many(*elements)
      elements.each { |element| add element }
    end
  end
end

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
        bin.add_many(*elements)
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

    private

    def elements
      @elements ||= [
        source,
        Gst::ElementFactory.make('decodebin', 'decoder'),
        Gst::ElementFactory.make('audioconvert', 'preconverter'),
        Gst::ElementFactory.make('audioresample', 'preresampler'),
        speed_changer,
        Gst::ElementFactory.make('audioconvert', 'postconverter'),
        Gst::ElementFactory.make('audioresample', 'postresampler'),
        Gst::ElementFactory.make('osssink', 'sink') ]
    end
  end
end
