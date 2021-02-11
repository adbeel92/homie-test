# frozen_string_literal: true

class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :rental_price, null: false, precision: 8, scale: 2
      t.string :status, null: false
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
