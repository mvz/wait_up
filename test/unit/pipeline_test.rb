require_relative '../test_helper'
require_relative '../../lib/wait_up/pipeline'

Gst.init []

describe WaitUp::Pipeline do
  let(:instance) { WaitUp::Pipeline.new 'file', 0.9 }
  describe '#pipeline' do
    it 'returns a Gst::Pipeline' do
      instance.pipeline.must_be_instance_of Gst::Pipeline
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
end
