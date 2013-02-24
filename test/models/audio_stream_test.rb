require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

class AudioStreamTest < Test::Unit::TestCase
  context "AudioStream Model" do
    should 'construct new instance' do
      @audio_stream = AudioStream.new
      assert_not_nil @audio_stream
    end
  end
end
