require 'gir_ffi-gst'

module Gst
  load_class :ChildProxy

  # TODO: Move to gir_ffi-gst
  module ChildProxy
    setup_instance_method :get_property

    def get_property(name)
      pspec = type_class.find_property name
      _v1 = GirFFI::InPointer.from(:utf8, name)
      _v2 = GObject::Value.for_gtype pspec.value_type
      Gst::Lib.gst_child_proxy_get_property self, _v1, _v2
      return _v2
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
