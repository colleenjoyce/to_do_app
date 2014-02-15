class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :task
      t.string :due_date

      t.timestamps
    end
  end
end
