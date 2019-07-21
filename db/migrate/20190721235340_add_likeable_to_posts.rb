class AddLikeableToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :likeable, polymorphic: true, index: true
  end
end
