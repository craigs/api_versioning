class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :teaser
      t.string :content

      t.timestamps
    end
  end
end
