import DesignSystem
import Foundation

struct Environment {
  public let themeProvider: ThemeStore

  static func prod() -> Environment {
    let themeProvider = ThemeProvider(syncKeyValueStorage: UserDefaults.standard)

    return Environment(
      themeProvider: themeProvider
    )
  }

  private init(
    themeProvider: ThemeStore
  ) {
    self.themeProvider = themeProvider
  }
}

extension UserDefaults: SyncKeyValueStorage {
  public func bool(forKey defaultName: String, defaultValue: Bool) -> Bool {
    guard let value = object(forKey: defaultName), let boolValue = value as? Bool else {
      return defaultValue
    }
    return boolValue
  }
}
