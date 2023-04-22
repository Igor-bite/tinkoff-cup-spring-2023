import UIKit

public enum ThemeSetting: String {
  case dark
  case light
  case system
}

public enum Theme: String, RawRepresentable {
  case dark
  case light
}

extension Theme {
  public init(userInterfaceStyle: UIUserInterfaceStyle) {
    switch userInterfaceStyle {
    case .light, .unspecified:
      self = .light
    case .dark:
      self = .dark
    @unknown default:
      self = .light
    }
  }
}

public protocol ThemeObserver: AnyObject {
  func themeDidChange()
}

public protocol ThemeStoring {
  func setThemeSetting(_ themeSetting: ThemeSetting)
  func systemThemeDidChange()
  var currentThemeSetting: ThemeSetting { get }
}

public protocol ThemeProviding {
  var currentTheme: Theme { get }
  var colors: BrandBook.Colors { get }

  func addObserver(_ observer: ThemeObserver)
  func removeObserver(_ observer: ThemeObserver)

  func colors(for theme: Theme) -> BrandBook.Colors
}

extension ThemeProviding {
  public var systemStyle: UIUserInterfaceStyle {
    switch currentTheme {
    case .light:
      return .light
    case .dark:
      return .dark
    }
  }
}

extension ThemeProviding {
  public var keyboardAppearance: UIKeyboardAppearance {
    currentTheme == .light ? .light : .dark
  }
}

public class DarkOnlyThemeProvider: ThemeProviding {
  public var currentTheme: Theme { .dark }
  public var colors: BrandBook.Colors { colors(for: currentTheme) }

  public init() {}

  public func addObserver(_: ThemeObserver) {}
  public func removeObserver(_: ThemeObserver) {}

  public func colors(for _: Theme) -> BrandBook.Colors {
    BrandBook.Colors.dark
  }
}

public class LightOnlyThemeProvider: ThemeProviding {
  public var currentTheme: Theme { .light }
  public var colors: BrandBook.Colors { colors(for: currentTheme) }

  public init() {}

  public func addObserver(_: ThemeObserver) {}
  public func removeObserver(_: ThemeObserver) {}

  public func colors(for _: Theme) -> BrandBook.Colors {
    BrandBook.Colors.light
  }
}
