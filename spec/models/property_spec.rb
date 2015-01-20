require 'rails_helper'

describe Property do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
