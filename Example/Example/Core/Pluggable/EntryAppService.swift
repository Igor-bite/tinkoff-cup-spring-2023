import UIKit

final class EntryAppService: AppService {
  private var window: UIWindow!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    let themeProvider = AppEnvironment.current.themeProvider
    let nc = UINavigationController(rootViewController: ComponentsController(themeProvider: themeProvider))
    setupWindow(root: nc)
    return true
  }

  private func setupWindow(root: UIViewController) {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = root
    window?.makeKeyAndVisible()
  }
}
