class CreateCmsPages < ActiveRecord::Migration
  def change
    create_table :cms_pages do |t|
      t.string :name, null: false
      t.string :path, null: false
      t.string :locale, default: 'en'

      t.timestamps null: false
    end
  end
end
