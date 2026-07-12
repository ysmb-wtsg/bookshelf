# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 既存のタグをすべて削除（開発環境のみ）
Tag.destroy_all

# タグのデータを作成
tags = [
  'Ruby',
  '設計',
  '小説',
  'ビジネス',
  '自己啓発'
]

tags.each do |tag_name|
  Tag.create!(name: tag_name)
end

puts "タグを #{Tag.count} 件作成しました ✓"