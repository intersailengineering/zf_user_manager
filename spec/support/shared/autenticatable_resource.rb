require 'spec_helper'

module IntersailAuth
  shared_examples "authenticatable_resource" do
    let(:user) { described_class.new}

    it "should act as devise model" do
      expect(user.class).to extends(Devise::Models)
    end

    it "should act as active_model" do
      expect(user.class).to inherit_from(ActiveRecord::Base)
    end

    it "should have user fields" do
      expect(user).to have_attr_accessor(:username)
      expect(user).to have_attr_accessor(:password)
    end
  end
end
