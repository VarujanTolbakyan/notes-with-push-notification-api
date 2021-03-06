class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :name
      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true

    User.create email: 'admin@gmail.com', password: 'admin', admin: true
  end
end
