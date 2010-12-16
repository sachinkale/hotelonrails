class User < ActiveRecord::Base
  belongs_to :role
  acts_as_authentic
end
