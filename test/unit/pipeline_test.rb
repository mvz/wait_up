require_relative '../test_helper'
require_relative '../../lib/wait_up/pipeline'

Gst.init []

# TODO: Extract to a gem
module Gst
  load_class :Iterator
  class Iterator
    include Enumerable

    def each
      prc = proc { |item, _ud| yield item.get_value }
      foreach(prc, nil)
    end
  end
end

describe WaitUp::Pipeline do
  let(:instance) { WaitUp::Pipeline.new 'file', 0.9 }

  describe '#pipeline' do
    let(:pipeline) { instance.pipeline }

    it 'returns a Gst::Pipeline' do
      pipeline.must_be_instance_of Gst::Pipeline
    end

    it 'has the correct build-up' do
      iter = pipeline.iterate_elements

      values = iter.to_a
      values.reverse.map(&:get_name).must_equal [
        'source', 'decoder', 'preconverter', 'preresampler',
        'speed changer', 'postconverter', 'postresampler', 'sink']
    end
  end

  describe '#source' do
    let(:source) { instance.source }
    it 'returns a Gst::Element' do
      source.must_be_kind_of Gst::Element
    end

    it 'has the correct location' do
      source.get_property("location").get_value.must_equal 'file'
    end
  end

  describe '#speed_changer' do
    let(:speed_changer) { instance.speed_changer }
    it 'returns a Gst::Element' do
      speed_changer.must_be_kind_of Gst::Element
    end

    it 'has the correct tempo' do
      speed_changer.get_property("tempo").get_value.must_be_close_to 0.9
    end
  end
end
