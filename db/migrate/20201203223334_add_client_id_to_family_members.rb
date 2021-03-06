class AddClientIdToFamilyMembers < ActiveRecord::Migration
  def change
    add_reference :family_members, :client, foreign_key: true
    add_column :family_members, :monthly_income, :decimal, precision: 10, scale: 2
  end
end
