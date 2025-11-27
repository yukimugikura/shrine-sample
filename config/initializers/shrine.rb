require "shrine"
require "shrine/storage/file_system"

# ローカルストレージの設定
Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"),
  store: Shrine::Storage::FileSystem.new("public", prefix: "uploads")
}

# プラグインの読み込み
Shrine.plugin :activerecord # ActiveRecordとの連携を有効化