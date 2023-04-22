import UIKit

extension UIColor {
  /// Initializes color from hex representation in RGB format with alpha = 1
  public convenience init(rgb: UInt32) {
    self.init(rgb: rgb, alpha: 1)
  }

  /// Initializes color from hex representation in RGB format with specified alpha (from 0 to 1)
  public convenience init(rgb: UInt32, alpha: Float) {
    let red = CGFloat((rgb & 0xFF0000) >> 16) / 255
    let green = CGFloat((rgb & 0x00FF00) >> 8) / 255
    let blue = CGFloat(rgb & 0x0000FF) / 255
    self.init(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
  }

  public convenience init(rgba: UInt64) {
    let red = CGFloat((rgba & 0x0000_FF00_0000) >> 24) / 255
    let green = CGFloat((rgba & 0x0000_00FF_0000) >> 16) / 255
    let blue = CGFloat((rgba & 0x0000_0000_FF00) >> 8) / 255
    let alpha = CGFloat((rgba & 0x0000_0000_00FF) >> 0) / 255
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  public convenience init(argb: UInt64) {
    let alpha = CGFloat((argb & 0x0000_FF00_0000) >> 24) / 255
    let red = CGFloat((argb & 0x0000_00FF_0000) >> 16) / 255
    let green = CGFloat((argb & 0x0000_0000_FF00) >> 8) / 255
    let blue = CGFloat((argb & 0x0000_0000_00FF) >> 0) / 255
    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
