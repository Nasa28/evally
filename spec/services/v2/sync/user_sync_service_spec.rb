# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V2::Sync::UserSyncService do
  describe '.perform' do
    it 'expects to make a post request' do
      user = FactoryBot.create(:user, role: :admin)

      stub_request(:post, 'http://testhost_recruitable/v2/users/webhook')
        .with(
          body: {
            user: user.attributes.slice(
              'email', 'first_name', 'last_name', 'role', 'status', 'signature'
            )
          },
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'Token' => JwtService.encode(user)
          }
        )
        .to_return(status: 204, body: '', headers: {})

      described_class.new(user, user).perform
    end
  end
end
