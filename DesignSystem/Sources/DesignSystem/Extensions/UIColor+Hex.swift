import UIKit

extension UIColor {
  public convenience init(hex: String, specification: HexSpecification = .RGBA) {
    let rgba: RGBA

    switch specification {
    case .RGBA:
      rgba = ColorUtils.hexToRGBA(hex)
    case .ARGB:
      rgba = ColorUtils.hexToARGB(hex)
    }

    self.init(rgba: rgba)
  }

  public convenience init(rgba: RGBA) {
    self.init(
      red: CGFloat(rgba.r) / 255,
      green: CGFloat(rgba.g) / 255,
      blue: CGFloat(rgba.b) / 255,
      alpha: CGFloat(rgba.a) / 255
    )
  }
}
