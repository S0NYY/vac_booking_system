class CreateVerifySmsMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :verify_sms_messages do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :code
      t.datetime :approved_at
      t.datetime :sent_at

      t.timestamps
    end
  end
end
