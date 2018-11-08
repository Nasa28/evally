require 'rails_helper'

RSpec.describe Employee, type: :model do

  it { is_expected.to have_db_index(:last_name) }

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:first_name) }

  it { is_expected.to validate_presence_of(:last_name) }

  it { is_expected.to validate_presence_of(:position) }

  it { is_expected.to validate_presence_of(:hired_at) }

end