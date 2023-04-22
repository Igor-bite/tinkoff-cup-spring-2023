import Foundation
import UIKit

extension String {
  public func styled(_ style: Typo) -> NSAttributedString {
    NSAttributedString(string: self, attributes: style.attributes)
  }

  public func mutableStyled(_ style: Typo) -> NSMutableAttributedString {
    NSMutableAttributedString(string: self, attributes: style.attributes)
  }
}

fileprivate func setOptional<T>(_ value: T?, _ setter: (T) -> Void) {
  if let value = value {
    setter(value)
  }
}

extension Dictionary {
  fileprivate mutating func fastNonResettingSetValue(_ value: Value?, for key: Key) {
    setOptional(value) { self[key] = $0 }
  }
}

public struct Typo: Equatable, Hashable {
  private let font: UIFont?
  private let fontWeight: UIFont.Weight?
  private let italic: Bool?
  private let strikethrough: Bool?
  private let tracking: CGFloat?
  private let color: UIColor?
  private let linkColor: UIColor?
  private let paragraphStyle: NSParagraphStyle?
  private let alignment: NSTextAlignment?
  private let lineBreakMode: NSLineBreakMode?
  private let lineHeightInternal: CGFloat?

  public var attributes: [NSAttributedString.Key: Any] {
    var result: [NSAttributedString.Key: Any] = .init(minimumCapacity: 11)
    result.fastNonResettingSetValue(font, for: .font)
    result.fastNonResettingSetValue(paragraphStyle, for: .paragraphStyle)

    if let linkColor = linkColor {
      result.fastNonResettingSetValue(linkColor, for: .foregroundColor)
    } else {
      result.fastNonResettingSetValue(color, for: .foregroundColor)
    }

    if let strikethrough = strikethrough {
      result.fastNonResettingSetValue(strikethrough ? 1 : 0, for: .strikethroughStyle)
    }

    return result
  }

  public init(
    font: UIFont? = nil,
    fontWeight: UIFont.Weight? = nil,
    italic: Bool? = nil,
    strikethrough: Bool? = nil,
    tracking: CGFloat? = nil,
    lineHeight: CGFloat? = nil,
    color: UIColor? = nil,
    linkColor: UIColor? = nil,
    paragraphStyle: NSParagraphStyle? = nil,
    alignment: NSTextAlignment? = nil,
    lineBreakMode: NSLineBreakMode? = nil
  ) {
    if let p = paragraphStyle {
      self.paragraphStyle = p
    } else {
      let paragraphStyle = NSMutableParagraphStyle()
      if let lineHeight = lineHeight {
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
      }
      paragraphStyle.alignment = alignment ?? .natural
      paragraphStyle.lineBreakMode = lineBreakMode ?? .byWordWrapping
      self.paragraphStyle = paragraphStyle
    }

    var fontResult = font

    if let weight = fontWeight {
      fontResult = fontResult?.withWeight(weight)
    }
    if let italic = italic, italic == true {
      fontResult = fontResult?.withItalic()
    }

    self.font = fontResult
    self.fontWeight = fontWeight
    self.italic = italic
    self.strikethrough = strikethrough
    self.tracking = tracking
    self.lineHeightInternal = lineHeight
    self.color = color
    self.linkColor = linkColor
    self.alignment = alignment
    self.lineBreakMode = lineBreakMode
  }
}

extension Typo {
  public static func + (lhs: Typo, rhs: Typo) -> Typo {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = lhs.lineHeightInternal ?? rhs.lineHeightInternal ?? 0
    paragraphStyle.maximumLineHeight = lhs.lineHeightInternal ?? rhs.lineHeightInternal ?? 0
    paragraphStyle.alignment = lhs.alignment ?? rhs.alignment ?? .natural
    paragraphStyle.lineBreakMode = lhs.lineBreakMode ?? rhs.lineBreakMode ?? .byWordWrapping

    return Typo(
      font: rhs.font ?? lhs.font,
      fontWeight: rhs.fontWeight ?? lhs.fontWeight,
      italic: rhs.italic ?? lhs.italic,
      strikethrough: rhs.strikethrough ?? lhs.strikethrough,
      tracking: rhs.tracking ?? lhs.tracking,
      lineHeight: rhs.lineHeightInternal ?? lhs.lineHeightInternal,
      color: rhs.color ?? lhs.color,
      linkColor: rhs.linkColor ?? lhs.linkColor,
      paragraphStyle: paragraphStyle,
      alignment: rhs.alignment ?? lhs.alignment,
      lineBreakMode: rhs.lineBreakMode ?? lhs.lineBreakMode
    )
  }

  public func with(lineHeight: CGFloat) -> Typo {
    self + Typo(lineHeight: lineHeight)
  }

  public func withItalic() -> Typo {
    self + Typo(italic: true)
  }

  public func withStrikethrough() -> Typo {
    self + Typo(strikethrough: true)
  }

  public func with(alignment: NSTextAlignment) -> Typo {
    self + Typo(alignment: alignment)
  }

  public func with(color: UIColor) -> Typo {
    self + Typo(color: color)
  }

  public func with(linkColor: UIColor) -> Typo {
    self + Typo(linkColor: linkColor)
  }

  public func with(lineBreakMode: NSLineBreakMode) -> Typo {
    self + Typo(lineBreakMode: lineBreakMode)
  }

  public func with(fontWeight: UIFont.Weight) -> Typo {
    self + Typo(fontWeight: fontWeight)
  }
}

extension UIFont {
  func withWeight(_ weight: UIFont.Weight) -> UIFont {
    let newDescriptor = fontDescriptor.addingAttributes([.traits: [UIFontDescriptor.TraitKey.weight: weight]])
    return UIFont(descriptor: newDescriptor, size: pointSize)
  }

  func withItalic() -> UIFont {
    withTraits(.traitItalic, ofSize: pointSize)
  }

  func withTraits(_ traits: UIFontDescriptor.SymbolicTraits..., ofSize size: CGFloat) -> UIFont {
    if let descriptor = fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) {
      return UIFont(descriptor: descriptor, size: size)
    } else {
      return self
    }
  }
}
