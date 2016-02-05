require_relative '../test_helper'
require_relative '../../lib/wait_up/pipeline'

Gst.init

def next_element(element)
  # FIXME: Reduce the number of necessary chained calls here.
  pad = element.iterate_src_pads.first
  peer = pad.get_peer if pad
  peer.parent if peer
end

describe WaitUp::Pipeline do
  # Empty mp3 file from http://www.xamuel.com/blank-mp3s/
  let(:filename) { File.join(File.dirname(__FILE__), '..', 'fixtures', 'point1sec.mp3') }
  let(:instance) { WaitUp::Pipeline.new filename, 0.9 }

  describe '#sink_bin' do
    let(:sink_bin) { instance.sink_bin }

    it 'returns a Gst::Bin' do
      sink_bin.must_be_instance_of Gst::Bin
    end

    it 'has the correct build-up' do
      iter = sink_bin.iterate_elements
      iter.map(&:name).must_equal ['speed changer', 'postconverter', 'audiosink']
    end

    it 'has the elements all linked up' do
      iter = sink_bin.iterate_elements

      iter.to_a.each_cons(2) do |src, dst|
        next_element(src).
          must_equal dst, "Expected #{src.name} to link up to #{dst.name}"
      end
    end

    it 'must have the state :paused' do
      sink_bin.get_state(0)[1].must_equal :paused
    end

    it 'must be linked up to a source' do
      sink_bin.iterate_sink_pads.first.get_peer.wont_be_nil
    end
  end

  describe '#play_bin' do
    let(:play_bin) { instance.play_bin }

    it 'must have the state :paused' do
      play_bin.get_state(0)[1].must_equal :paused
    end

    it 'has the correct source set up' do
      source = play_bin.get_property('source').get_value
      source.uri.must_equal "file://#{File.absolute_path filename}"
    end
  end

  describe '#speed_changer' do
    let(:speed_changer) { instance.speed_changer }
    it 'returns a Gst::Element' do
      speed_changer.must_be_kind_of Gst::Element
    end

    it 'has the correct tempo' do
      speed_changer.get_property('tempo').must_be_close_to 0.9
    end
  end

  describe '#play' do
    it "sets the play bin's state to :playing" do
      instance.play
      instance.play_bin.get_state(0)[1].must_equal :playing
    end
  end
end
