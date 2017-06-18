class CreateHistoryRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :history_records do |t|
      t.string :uid, null: false
      t.jsonb :data, default: {}

      t.timestamps
    end
    add_index :history_records, :uid, unique: true
    add_index :history_records, :data, using: :gin
    add_index :history_records, :created_at
    add_index :history_records, :updated_at
  end
end
