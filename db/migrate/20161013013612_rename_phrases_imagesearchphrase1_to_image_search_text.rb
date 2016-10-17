class RenamePhrasesImagesearchphrase1ToImageSearchText < ActiveRecord::Migration
  def change
    rename_column :phrases, :image_search_phrase1, :image_search_text
  end
end
