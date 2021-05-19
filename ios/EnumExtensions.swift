import GiphyUISDK

public extension GPHRenditionType {
  static func with(key: String) -> GPHRenditionType? {
    switch key {
    case "original":
      return .original
    case "originalStill":
      return .originalStill
    case "preview":
      return .preview
    case "looping":
      return .looping
    case "fixedHeight":
      return .fixedHeight
    case "fixedHeightStill":
      return .fixedHeightStill
    case "fixedHeightDownsampled":
      return .fixedHeightDownsampled
    case "fixedHeightSmall":
      return .fixedHeightSmall
    case "fixedHeightSmallStill":
      return .fixedHeightSmallStill
    case "fixedWidth":
      return .fixedWidth
    case "fixedWidthStill":
      return .fixedWidthStill
    case "fixedWidthDownsampled":
      return .fixedWidthDownsampled
    case "fixedWidthSmall":
      return .fixedWidthSmall
    case "fixedWidthSmallStill":
      return .fixedWidthSmallStill
    case "downsized":
      return .downsized
    case "downsizedSmall":
      return .downsizedSmall
    case "downsizedMedium":
      return .downsizedMedium
    case "downsizedLarge":
      return .downsizedLarge
    case "downsizedStill":
      return .downsizedStill
    default:
      return nil
    }
  }
}

public extension GPHFileExtension {
  static func with(key: String) -> GPHFileExtension? {
    switch key {
    case "mp4":
      return .mp4
    case "gif":
      return .gif
    case "webp":
      return .webp
    default:
      return nil
    }
  }
}

public extension GPHContentType {
  static func with(key: String) -> GPHContentType? {
    switch key {
    case "gifs":
      return .gifs
    case "stickers":
      return .stickers
    case "text":
      return .text
    case "emoji":
      return .emoji
    default:
      return nil
    }
  }
}

public extension GPHTheme {
  static func with(key: String) -> GPHTheme? {
    switch key {
    case "automatic":
        return GPHTheme(type: .automatic)
    case "light":
        return GPHTheme(type: .light)
    case "dark":
        return GPHTheme(type: .dark)
    default:
        return nil
    }
  }
}
