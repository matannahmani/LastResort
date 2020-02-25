class AddSpecialityToUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :speciality, :string
  end
end
