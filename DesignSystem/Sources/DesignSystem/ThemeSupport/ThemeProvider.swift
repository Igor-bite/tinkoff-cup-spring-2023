import UIKit

public final class ThemeProvider: ThemeProviding, ThemeStoring {
  private let themeSettingsKey = "themeSettingsKey"
  private let syncKeyValueStorage: SyncKeyValueStorage
  public private(set) var currentTheme: Theme
  public private(set) var currentThemeSetting: ThemeSetting
  public var colors: BrandBook.Colors { colors(for: currentTheme) }

  private var observers: [WeakObserver] = []

  public init(
    syncKeyValueStorage: SyncKeyValueStorage
  ) {
    self.syncKeyValueStorage = syncKeyValueStorage

    if let themeSettingInStorage = syncKeyValueStorage.string(forKey: themeSettingsKey),
       let themeSetting = ThemeSetting(rawValue: themeSettingInStorage)
    {
      self.currentThemeSetting = themeSetting
    } else {
      self.currentThemeSetting = .system
    }

    self.currentTheme = Self.getThemeBy(themeSetting: self.currentThemeSetting)
  }

  public func addObserver(_ observer: ThemeObserver) {
    observers = observers.filter { $0.value != nil }

    guard observers.first(where: { $0.value === observer }) == nil else { return }
    observers.append(WeakObserver(value: observer))
  }

  public func removeObserver(_ observer: ThemeObserver) {
    observers = observers.filter { $0.value != nil && $0.value !== observer }
  }

  private static func getThemeBy(themeSetting: ThemeSetting) -> Theme {
    switch themeSetting {
    case .light:
      return .light
    case .dark:
      return .dark
    case .system:
      return Theme(userInterfaceStyle: UIScreen.main.traitCollection.userInterfaceStyle)
    }
  }

  public func colors(for theme: Theme) -> BrandBook.Colors {
    switch theme {
    case .dark:
      return .dark
    case .light:
      return .light
    }
  }

  public func systemThemeDidChange() {
    if currentThemeSetting == .system {
      let newTheme = Theme(userInterfaceStyle: UIScreen.main.traitCollection.userInterfaceStyle)
      setTheme(newTheme)
    }
  }

  public func setThemeSetting(_ themeSetting: ThemeSetting) {
    self.currentThemeSetting = themeSetting
    syncKeyValueStorage.set(themeSetting.rawValue, forKey: themeSettingsKey)
    let newTheme = Self.getThemeBy(themeSetting: themeSetting)
    setTheme(newTheme)
  }

  private func setTheme(_ theme: Theme) {
    guard currentTheme != theme else {
      return
    }
    currentTheme = theme
    observers = observers.filter { $0.value != nil }
    observers.forEach { $0.value?.themeDidChange() }
  }
}

private class WeakObserver {
  weak var value: ThemeObserver?

  init(value: ThemeObserver) {
    self.value = value
  }
}
