class AddProgramsToNetworkEvents < ActiveRecord::Migration
  def change
    add_reference :network_events, :program, index: true, foreign_key: true
  end
end
