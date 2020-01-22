import Foundation
import GiphyUISDK
import GiphyCoreSDK

struct RNGiphyKeyboardEvents {
  static let mediaSelected = "mediaSelected"
  static let giphyDismissed = "giphyDismissed"
}

@objc(RNGiphyKeyboard)
open class RNGiphyKeyboard: RCTEventEmitter, GiphyDelegate {
  let rootViewController = UIApplication.shared.keyWindow!.rootViewController!

  var giphy: GiphyViewController?
  var rendition: GPHRenditionType?
  var fileType: GPHFileExtension?

  // MARK: Initialization
  override init() {
    super.init()

    if let apiKey = Bundle.main.infoDictionary?["GiphyApiKey"] as? String {
      GiphyUISDK.configure(apiKey: apiKey)
    }
  }

  override public static func moduleName() -> String! {
    return "RNGiphyKeyboard"
  }

  override public static func requiresMainQueueSetup() -> Bool {
    return true
  }

  open override func supportedEvents() -> [String]! {
    return [
      RNGiphyKeyboardEvents.mediaSelected,
      RNGiphyKeyboardEvents.giphyDismissed
    ]
  }

  // MARK: React Methods
  @objc func openGiphy(_ options: NSDictionary?) {
    DispatchQueue.main.async {
      let giphy = GiphyViewController()

      if let mediaTypes = options?["mediaTypes"] as? [String] {
        let mediaTypeConfig = mediaTypes.map({ GPHContentType.with(key: $0) }).filter({ $0 != nil }) as! [GPHContentType]

        giphy.mediaTypeConfig = mediaTypeConfig
      }
      giphy.delegate = self

      if let rendition = options?["rendition"] as? String {
        self.rendition = GPHRenditionType.with(key: rendition)
      }
      if let fileType = options?["fileType"] as? String {
        self.fileType = GPHFileExtension.with(key: fileType)
      }

      self.giphy = giphy

      self.rootViewController.present(giphy, animated: true)
    }
  }

  @objc func dismissGiphy() {
    DispatchQueue.main.async {
      self.giphy?.dismiss(animated: true, completion: nil)
    }
  }

  // MARK: Giphy Delegate Stubs
  open func didSelectMedia(giphyViewController: GiphyViewController, media: GPHMedia) {
    sendEvent(withName: RNGiphyKeyboardEvents.mediaSelected, body: [
      "url": media.url(rendition: self.rendition ?? .original, fileType: self.fileType ?? .mp4) as Any,
      "aspectRatio": media.aspectRatio
    ])
  }

  open func didDismiss(controller: GiphyViewController?) {
    sendEvent(withName: RNGiphyKeyboardEvents.giphyDismissed, body: nil)
  }
}
