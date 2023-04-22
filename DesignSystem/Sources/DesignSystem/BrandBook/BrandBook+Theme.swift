extension BrandBook.Colors {
  public static let light = Self(
    applied: .light,
    background: .light,
    text: .light
  )

  public static let dark = Self(
    applied: .dark,
    background: .dark,
    text: .dark
  )
}

extension BrandBook.Colors.Applied {
  public static let light = Self(
    buttonBgNormal: Color(hex: "00102408"),
    buttonBgHighlighted: Color(hex: "0010240F"),
    iconBg: Color(hex: "F6F7F8"),
    iconPrimary: Color(hex: "9299A2")
  )

  public static let dark = Self.light
}

extension BrandBook.Colors.Background {
  public static let light = Self(
    primary: Color(hex: "FFFFFF"),
    inverted: Color(hex: "F6F7F8")
  )

  public static let dark = Self.light
}

extension BrandBook.Colors.Text {
  public static let light = Self(
    accent: Color(hex: "428BF9"),
    primary: Color(hex: "333333"),
    secondary: Color(hex: "9299A2")
  )

  public static let dark = Self.light
}
