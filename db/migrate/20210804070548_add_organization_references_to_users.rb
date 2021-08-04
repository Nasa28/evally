class AddOrganizationReferencesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :organization, foreign_key: true

    Template.joins(:creator).update_all('organization_id = users.organization_id')

    change_column_null :users, :organization_id, false
  end
end
