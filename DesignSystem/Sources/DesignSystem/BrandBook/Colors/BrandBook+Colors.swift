extension BrandBook {
  public struct Colors {
    public let applied: Applied
    public let background: Background
    public let text: Text

    public init(
      applied: Applied,
      background: Background,
      text: Text
    ) {
      self.applied = applied
      self.background = background
      self.text = text
    }
  }
}

extension BrandBook.Colors {
  public struct Applied {
    public let buttonBgNormal: Color
    public let buttonBgHighlighted: Color
    public let iconBg: Color
    public let iconPrimary: Color

    public init(
      buttonBgNormal: Color,
      buttonBgHighlighted: Color,
      iconBg: Color,
      iconPrimary: Color
    ) {
      self.buttonBgNormal = buttonBgNormal
      self.buttonBgHighlighted = buttonBgHighlighted
      self.iconBg = iconBg
      self.iconPrimary = iconPrimary
    }
  }
}

extension BrandBook.Colors {
  public struct Background {
    public let primary: Color
    public let inverted: Color

    public init(
      primary: Color,
      inverted: Color
    ) {
      self.primary = primary
      self.inverted = inverted
    }
  }
}

extension BrandBook.Colors {
  public struct Text {
    public let accent: Color
    public let primary: Color
    public let secondary: Color

    public init(
      accent: Color,
      primary: Color,
      secondary: Color
    ) {
      self.accent = accent
      self.primary = primary
      self.secondary = secondary
    }
  }
}
