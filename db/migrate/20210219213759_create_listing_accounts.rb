# frozen_string_literal: true

class CreateListingAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :listing_accounts do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
