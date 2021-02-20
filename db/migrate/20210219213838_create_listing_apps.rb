# frozen_string_literal: true

class CreateListingApps < ActiveRecord::Migration[6.1]
  def change
    create_table :listing_apps do |t|
      t.string :api_key, null: false
      t.string :api_secret, null: false
      t.references :listing_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
