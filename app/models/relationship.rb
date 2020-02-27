class Relationship < ApplicationRecord
  belongs_to :user, class_name: 'User'
  # belongs_toで指定するのはモデル。モデル名が存在しない時は、class_nameのオプションを使う
  belongs_to :follow, class_name: 'User'
end
