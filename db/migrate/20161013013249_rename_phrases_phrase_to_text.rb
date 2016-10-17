class RenamePhrasesPhraseToText < ActiveRecord::Migration
  def change
    rename_column :phrases, :phrase, :text
  end
end
