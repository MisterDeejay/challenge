class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers, id: :uuid do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :name
      t.boolean :subscribed, null: false, default: true

      t.timestamps
    end
  end
end
