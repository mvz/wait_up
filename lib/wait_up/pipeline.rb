# frozen_string_literal: true

require 'gstreamer'

module WaitUp
  # Wait Up pipeline class
  class Pipeline
    attr_reader :filename, :tempo

    def initialize(filename, tempo)
      @filename = filename
      @tempo = tempo

      fill_sink_bin
      link_elements

      set_up_play_bin
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

    private

    def fill_sink_bin
      sink_bin.add audiosink
      sink_bin.add postconverter
      sink_bin.add speed_changer
      sink_bin.add_pad speed_changer_ghost_pad
    end

    def speed_changer_ghost_pad
      @speed_changer_ghost_pad ||= Gst::GhostPad.new 'sink', speed_changer.sinkpads.first
    end

    def link_elements
      speed_changer.link postconverter
      postconverter.link audiosink
    end

    def set_up_play_bin
      play_bin.set_property 'uri', "file://#{File.absolute_path(filename)}"
      play_bin.audio_sink = sink_bin
      play_bin.state = :paused
      play_bin.get_state(-1)
    end
  end
end
