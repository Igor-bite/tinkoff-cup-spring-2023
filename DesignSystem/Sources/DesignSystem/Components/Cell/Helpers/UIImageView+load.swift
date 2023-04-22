import Foundation
import UIKit

final class LoadableImageView: UIImageView {
  private var loadingUrl: URL?
  private let loadingQueue = DispatchQueue(label: "ImageLoadingQueue", attributes: .concurrent)

  func load(fromUrl url: URL) {
    guard loadingUrl != url else { return }
    loadingUrl = url

    loadingQueue.async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        guard self?.loadingUrl == url else { return }
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self?.image = image
          }
        }
      }
    }
  }
}
