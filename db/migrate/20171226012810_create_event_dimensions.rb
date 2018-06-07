class CreateEventDimensions < ActiveRecord::Migration[5.1]
  def change
    create_table :event_dimensions do |t|
      t.string :location
      t.string :program
    end
  end
end
