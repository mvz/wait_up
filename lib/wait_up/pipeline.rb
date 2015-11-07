require 'gir_ffi-gst'

module WaitUp
  # Wait Up pipeline class
  class Pipeline
    attr_reader :filename, :tempo

    def initialize(filename, tempo)
      @filename = filename
      @tempo = tempo
      pipeline.add_many(elements)
      source.link decoder
      pipeline.set_state :ready
      pipeline.get_state(-1)
      source.set_state :paused
      decoder.set_state :paused
      decoder.get_state(-1)
      decoder.link_many elements[2..-1]
      decoder.set_state :paused
      decoder.get_state(-1)
    end

    def play
      puts "Playing #{filename} at tempo #{tempo}"
    end

    def pipeline
      @pipeline ||= Gst::Pipeline.new('pipeline')
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

    def decoder
      @decoder ||= Gst::ElementFactory.make('decodebin', 'decoder')
    end

    def elements
      @elements ||= [
        source,
        decoder,
        preconverter,
        speed_changer,
        Gst::ElementFactory.make('audioconvert', 'postconverter'),
        Gst::ElementFactory.make('autoaudiosink', 'audiosink') ]
    end

    def preconverter
      @preconverter ||= Gst::ElementFactory.make('audioconvert', 'preconverter')
    end
  end
end
