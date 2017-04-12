class CommonTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :class_name => "User"
end
