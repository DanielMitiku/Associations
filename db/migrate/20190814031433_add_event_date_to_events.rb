# frozen_string_literal: true

class AddEventDateToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_date, :date
  end
end
