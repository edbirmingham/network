class AddParticipationTypeToParticipations < ActiveRecord::Migration[5.1]
  def change
    add_column :participations, :participation_type, :string
  end
end
