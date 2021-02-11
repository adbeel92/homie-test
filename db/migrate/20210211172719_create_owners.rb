# frozen_string_literal: true

class CreateOwners < ActiveRecord::Migration[6.1]
  def change
    create_table :owners do |t|
      t.string :name, null: false
      t.string :phone, null: false

      t.timestamps
    end
  end
end
