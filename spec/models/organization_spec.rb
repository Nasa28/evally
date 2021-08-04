# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
