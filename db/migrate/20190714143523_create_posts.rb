class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :author, index: true
      t.string :content

      t.timestamps
    end
  end
end
