class AddGetInviteRequestsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :get_invite_requests, :boolean
  end
end
