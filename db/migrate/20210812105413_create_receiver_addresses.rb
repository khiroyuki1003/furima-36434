class CreateReceiverAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :receiver_addresses do |t|

      t.timestamps  
    end
  end
end
