import DesignSystem
import UIKit

public typealias ThemeStore = ThemeProviding & ThemeStoring

protocol ThemeSwitchable where Self: UIViewController {
  var themeProvider: ThemeStore { get }

  func addSwitchButton()
  func switchTheme()
  func setTheme(_ newTheme: ThemeSetting)
  func updateSystemStyle()
}

extension ThemeSwitchable {
  func addSwitchButton() {
    let button = UIBarButtonItem(
      image: .init(systemName: "switch.2"),
      primaryAction: UIAction(handler: { [weak self] _ in
        self?.switchTheme()
      })
    )
    let items = navigationItem.rightBarButtonItems ?? []
    navigationItem.setRightBarButtonItems(items + [button], animated: true)
  }

  func switchTheme() {
    print("themeProvider.currentThemeSetting: \(themeProvider.currentThemeSetting)")

    var newTheme: ThemeSetting

    if themeProvider.currentThemeSetting == .system {
      if UIApplication.shared.windows.first?.overrideUserInterfaceStyle == .light {
        newTheme = .dark
      } else {
        newTheme = .light
      }
    } else {
      if themeProvider.currentThemeSetting == .light {
        newTheme = .dark
      } else {
        newTheme = .light
      }
    }

    setTheme(newTheme)
  }

  func setTheme(_ newTheme: ThemeSetting) {
    themeProvider.setThemeSetting(newTheme)
    updateSystemStyle()
  }

  func updateSystemStyle() {
    let theme: ThemeSetting = themeProvider.currentThemeSetting
    UIApplication.shared.windows.forEach { window in
      window.overrideUserInterfaceStyle = theme == .dark ? .dark : .light
    }
  }
}
