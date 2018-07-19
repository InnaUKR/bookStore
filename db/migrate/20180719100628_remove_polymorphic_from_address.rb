class RemovePolymorphicFromAddress < ActiveRecord::Migration[5.1]
  def change
    remove_reference :addresses, :addressable, polymorphic: true, index: true
  end
end
