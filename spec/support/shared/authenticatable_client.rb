require 'spec_helper'

module IntersailAuth
  shared_examples "authenticatable_client" do
    let(:client) { described_class.new }

    it "should be authenticatable" do
      expect(client.respond_to?(:tryToLogin)).to be true
      expect(client.method(:tryToLogin).parameters).to be == [[:opt, :authentication_hash]]
    end
  end
end