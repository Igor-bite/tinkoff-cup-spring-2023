import UIKit

public enum ColorUtils {
  public static func RGBAtoHSL(_ rgba: RGBA) -> HSL {
    let r = CGFloat(rgba.r) / 255.0
    let g = CGFloat(rgba.g) / 255.0
    let b = CGFloat(rgba.b) / 255.0

    let maxV = max(r, max(g, b))
    let minV = min(r, min(g, b))
    let d = maxV - minV

    var h: CGFloat = 0
    if maxV != minV {
      if maxV == r {
        h = ((g - b) / d).truncatingRemainder(dividingBy: 6)
      } else if maxV == g {
        h = (b - r) / d + 2
      } else if maxV == b {
        h = (r - g) / d + 4
      }
    }
    h = (h * 60).truncatingRemainder(dividingBy: 360)
    if h < 0 {
      h += 360
    }
    let l: CGFloat = (maxV + minV) / 2.0
    let s: CGFloat = d / (1 - abs(2 * l - 1))

    return HSL(
      h: max(0, min(Float(h), 360)),
      s: max(0, min(Float(s), 1)),
      l: max(0, min(Float(l), 1))
    )
  }

  public static func HSLtoRGBA(_ hsl: HSL) -> RGBA {
    let h = hsl.h
    let s = hsl.s
    let l = hsl.l

    let c = (1 - abs(2 * l - 1)) * s
    let m = l - 0.5 * c
    let x = c * (1 - abs((h / 60).truncatingRemainder(dividingBy: 2) - 1))

    let hueSegment = Int(h / 60)

    var r: UInt8
    var g: UInt8
    var b: UInt8

    switch hueSegment {
    case 0:
      r = UInt8(round(255 * (c + m)))
      g = UInt8(round(255 * (x + m)))
      b = UInt8(round(255 * m))
    case 1:
      r = UInt8(round(255 * (x + m)))
      g = UInt8(round(255 * (c + m)))
      b = UInt8(round(255 * m))
    case 2:
      r = UInt8(round(255 * m))
      g = UInt8(round(255 * (c + m)))
      b = UInt8(round(255 * (x + m)))
    case 3:
      r = UInt8(round(255 * m))
      g = UInt8(round(255 * (x + m)))
      b = UInt8(round(255 * (c + m)))
    case 4:
      r = UInt8(round(255 * (x + m)))
      g = UInt8(round(255 * m))
      b = UInt8(round(255 * (c + m)))
    case 5 ... 6:
      r = UInt8(round(255 * (c + m)))
      g = UInt8(round(255 * m))
      b = UInt8(round(255 * (x + m)))
    default:
      r = 0
      g = 0
      b = 0
    }

    return RGBA(
      r: max(0, min(r, 255)),
      g: max(0, min(g, 255)),
      b: max(0, min(b, 255)),
      a: 255
    )
  }

  public static func hexToRGBA(_ hexString: String) -> RGBA {
    let input = hexString
      .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")
      .uppercased()

    switch input.count {
    case 3 /* #RGB */:
      let red = colorComponent(from: input, start: 0, length: 1)
      let green = colorComponent(from: input, start: 1, length: 1)
      let blue = colorComponent(from: input, start: 2, length: 1)
      return RGBA(r: red, g: green, b: blue, a: 255)
    case 4 /* #RGBA */:
      let red = colorComponent(from: input, start: 0, length: 1)
      let green = colorComponent(from: input, start: 1, length: 1)
      let blue = colorComponent(from: input, start: 2, length: 1)
      let alpha = colorComponent(from: input, start: 3, length: 1)
      return RGBA(r: red, g: green, b: blue, a: alpha)
    case 6 /* #RRGGBB */:
      let red = colorComponent(from: input, start: 0, length: 2)
      let green = colorComponent(from: input, start: 2, length: 2)
      let blue = colorComponent(from: input, start: 4, length: 2)
      return RGBA(r: red, g: green, b: blue, a: 255)
    case 8 /* #RRGGBBAA */:
      let red = colorComponent(from: input, start: 0, length: 2)
      let green = colorComponent(from: input, start: 2, length: 2)
      let blue = colorComponent(from: input, start: 4, length: 2)
      let alpha = colorComponent(from: input, start: 6, length: 2)
      return RGBA(r: red, g: green, b: blue, a: alpha)
    default:
      assertionFailure("Incorrect color code: \(hexString)")
      return RGBA(r: 0, g: 0, b: 0, a: 0)
    }
  }

  public static func hexToARGB(_ hexString: String) -> RGBA {
    let input = hexString
      .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")
      .uppercased()

    switch input.count {
    case 3 /* #RGB */:
      let red = colorComponent(from: input, start: 0, length: 1)
      let green = colorComponent(from: input, start: 1, length: 1)
      let blue = colorComponent(from: input, start: 2, length: 1)
      return RGBA(r: red, g: green, b: blue, a: 255)
    case 4 /* #ARGB */:
      let alpha = colorComponent(from: input, start: 0, length: 1)
      let red = colorComponent(from: input, start: 1, length: 1)
      let green = colorComponent(from: input, start: 2, length: 1)
      let blue = colorComponent(from: input, start: 3, length: 1)
      return RGBA(r: red, g: green, b: blue, a: alpha)
    case 6 /* #RRGGBB */:
      let red = colorComponent(from: input, start: 0, length: 2)
      let green = colorComponent(from: input, start: 2, length: 2)
      let blue = colorComponent(from: input, start: 4, length: 2)
      return RGBA(r: red, g: green, b: blue, a: 255)
    case 8 /* #AARRGGBB */:
      let alpha = colorComponent(from: input, start: 0, length: 2)
      let red = colorComponent(from: input, start: 2, length: 2)
      let green = colorComponent(from: input, start: 4, length: 2)
      let blue = colorComponent(from: input, start: 6, length: 2)
      return RGBA(r: red, g: green, b: blue, a: alpha)
    default:
      assertionFailure("Incorrect color code: \(hexString)")
      return RGBA(r: 0, g: 0, b: 0, a: 0)
    }
  }

  private static func colorComponent(from string: String, start: Int, length: Int) -> UInt8 {
    let substring = (string as NSString)
      .substring(with: NSRange(location: start, length: length))
    let fullHex = length == 2 ? substring : "\(substring)\(substring)"
    var hexComponent: UInt64 = 0

    Scanner(string: fullHex).scanHexInt64(&hexComponent)

    return UInt8(hexComponent)
  }

  public static func toHex(_ rgba: RGBA) -> String {
    String(format: "#%02X%02X%02X", rgba.r, rgba.g, rgba.b)
  }
}

public struct RGBA {
  public let r: UInt8
  public let g: UInt8
  public let b: UInt8
  public let a: UInt8

  public init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
    self.r = r
    self.g = g
    self.b = b
    self.a = a
  }
}

public struct HSL {
  public let h: Float
  public let s: Float
  public let l: Float

  public init(h: Float, s: Float, l: Float) {
    self.h = h
    self.s = s
    self.l = l
  }

  public func isDark() -> Bool {
    isYellow() ? (l < 0.4) : (l < 0.55)
  }

  public func getAdaptedL() -> Float {
    isYellow() ? (l * 1.5) : l
  }

  public func isYellow() -> Bool {
    h >= 30 && h < 95
  }
}

public enum HexSpecification {
  case RGBA
  case ARGB
}
