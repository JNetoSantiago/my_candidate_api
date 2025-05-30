class CreatePoliticians < ActiveRecord::Migration[8.0]
  def change
    create_table :politicians do |t|
      t.string :name
      t.string :cpf
      t.integer :external_id
      t.string :state
      t.string :party
      t.string :photo_url

      t.timestamps
    end
  end
end
