module Helpers
  module Object
    RSpec::Matchers.define :have_an_alias do |original_name, alias_name|
      match do |actual|
        expect(actual.method(original_name) ).to be == actual.method(alias_name)
      end
    end

    RSpec::Matchers.define :inherit_from do |klass|
      match do |actual|
        expect(actual < (klass) ).to be true
      end
    end

    RSpec::Matchers.define :extends do |klass|
      match do |actual|
        expect(actual.is_a? klass ).to be true
      end
    end

  end
end