class CreateClasses < ActiveRecord::Migration
  def change
  	create_table :classes do |t|
  		t.string :name
  		t.integer :periods
  		t.references :courses

  		t.timestamps
  	end
  end
end
