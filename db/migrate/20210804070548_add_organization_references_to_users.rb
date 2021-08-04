class AddOrganizationReferencesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :organization, foreign_key: true

    organization = Organization.find_or_create_by!(name: 'First Organization')
    User.update_all(organization_id: organization.id)

    change_column_null :users, :organization_id, false
  end
end
