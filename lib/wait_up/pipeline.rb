require 'gir_ffi-gst'

module WaitUp
  # Wait Up pipeline class
  class Pipeline
    attr_reader :filename, :tempo

    def initialize(filename, tempo)
      @filename = filename
      @tempo = tempo

      play_bin.set_property 'uri', "file://#{File.absolute_path(filename)}"

      sink_bin.add audiosink
      sink_bin.add postconverter
      sink_bin.add speed_changer

      speed_changer.link_many [postconverter, audiosink]

      sink_pad = Gst::GhostPad.new 'sink', speed_changer.iterate_sink_pads.first
      sink_bin.add_pad sink_pad

      play_bin.set_property 'audio-sink', GObject::Value.wrap_instance(sink_bin)
      play_bin.set_state :paused
      play_bin.get_state(-1)
    end

    def play
      play_bin.set_state :playing
    end

    def play_bin
      @play_bin ||= Gst::ElementFactory.make 'playbin', nil
    end

    def sink_bin
      @sink_bin ||= Gst::Bin.new('sinkbin')
    end

    def speed_changer
      @speed_changer ||= Gst::ElementFactory.make('pitch', 'speed changer').tap do |element|
        element.set_property 'tempo', tempo
      end
    end

    def audiosink
      @audiosink ||= Gst::ElementFactory.make('autoaudiosink', 'audiosink')
    end

    def postconverter
      @postconverter ||= Gst::ElementFactory.make('audioconvert', 'postconverter')
    end

    def preconverter
      @preconverter ||= Gst::ElementFactory.make('audioconvert', 'preconverter')
    end
  end
end
