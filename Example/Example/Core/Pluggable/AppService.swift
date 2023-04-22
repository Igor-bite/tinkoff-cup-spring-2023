import UIKit

public protocol AppService {
  func application(_ application: UIApplication,
                   willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool

  func applicationWillEnterForeground(_ application: UIApplication)
  func applicationDidEnterBackground(_ application: UIApplication)
  func applicationDidBecomeActive(_ application: UIApplication)
  func applicationWillResignActive(_ application: UIApplication)

  func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication)
  func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication)

  func applicationWillTerminate(_ application: UIApplication)
  func applicationDidReceiveMemoryWarning(_ application: UIApplication)

  func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
  func application(_ application: UIApplication,
                   didFailToRegisterForRemoteNotificationsWithError error: Error)

  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any])
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)

  func application(_ application: UIApplication,
                   supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
}

// MARK: - Optionals

extension AppService {
  public func application(_ application: UIApplication,
                          willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    true
  }

  public func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    true
  }

  public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    true
  }

  public func applicationWillEnterForeground(_ application: UIApplication) {}
  public func applicationDidEnterBackground(_ application: UIApplication) {}
  public func applicationDidBecomeActive(_ application: UIApplication) {}
  public func applicationWillResignActive(_ application: UIApplication) {}

  public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {}
  public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {}

  public func applicationWillTerminate(_ application: UIApplication) {}
  public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {}

  public func application(_ application: UIApplication,
                          didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {}
  public func application(_ application: UIApplication,
                          didFailToRegisterForRemoteNotificationsWithError error: Error) {}

  public func application(_ application: UIApplication,
                          didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {}
  public func application(_ application: UIApplication,
                          didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                          fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {}

  public func application(_ application: UIApplication,
                          supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
  {
    .portrait
  }
}
