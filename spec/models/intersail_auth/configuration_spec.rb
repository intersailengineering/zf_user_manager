require 'spec_helper'

module Intersail
  describe 'Configuration', type: :module do
    before(:all) do
      class ConfigurationOptions
        attr_accessor :setted
      end

      Configuration.configure do |config|
        config.setted = "value1"
      end
    end

    it "should read configuration item" do
      expect(Configuration.config.setted).to be == "value1"
    end

    it "should change configuration item" do
      expect { Configuration.config.setted = "value2" }.to change { Configuration.config.setted }.to("value2")
    end
  end
end
