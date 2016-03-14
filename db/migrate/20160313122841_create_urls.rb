class CreateUrls < ActiveRecord::Migration

  def up
    create_table :urls do |t|
      t.string :full_url  , null: false
      t.string :short_url , null: false
      t.timestamps
    end
    add_index(:urls, :full_url , unique: true)
    add_index(:urls, :short_url, unique: true)
  end

  def down
    remove_index(:urls, :full_url)
    remove_index(:urls, :short_url)
    drop_table(:urls)
  end

end
