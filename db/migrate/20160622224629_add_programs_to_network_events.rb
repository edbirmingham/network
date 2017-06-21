class AddProgramsToNetworkEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :network_events, :program, index: true, foreign_key: true
  end
end
