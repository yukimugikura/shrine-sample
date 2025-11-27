class ImageUploader < Shrine
  # プラグインの追加
  plugin :validation_helpers
  plugin :store_dimensions      # 画像の幅・高さを保存
  plugin :derivatives           # サムネイルなどの派生画像を生成
  
  # バリデーション
  Attacher.validate do
    validate_max_size 9 * 1024 * 1024, message: "画像は9MB以下にしてください" # 10 MB
    validate_mime_type %w[image/jpeg image/png image/gif image/webp]
  end
  
  # 派生画像の定義（サムネイルなど）
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    
    {
      small:  magick.resize_to_limit!(300, 300),
      medium: magick.resize_to_limit!(500, 500)
    }
  end
end
