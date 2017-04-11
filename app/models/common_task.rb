class CommonTask < ApplicationRecord
  belongs_to :user
  belongs_to :owner, :class_name => "User"
end
