import UIKit

open class PluggableAppDelegate: UIResponder, UIApplicationDelegate {
  public var window: UIWindow?

  /// Lazy implementation of application services list
  public lazy var lazyServices: [AppService] = services()

  /// List of application services for binding to `AppDelegate` events
  open func services() -> [AppService] {
    [ /* Populated from sub-class */ ]
  }
}

extension PluggableAppDelegate {
  // swiftlint:disable line_length
  public func application(_ application: UIApplication,
                          willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
  {
    lazyServices.reduce(true) {
      $0 && $1.application(application, willFinishLaunchingWithOptions: launchOptions)
    }
  }

  // swiftlint:enable line_length

  public func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    lazyServices.reduce(true) {
      $0 && $1.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
  }

  public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    lazyServices.reduce(true) {
      $0 && $1.application(app, open: url, options: options)
    }
  }
}

extension PluggableAppDelegate {
  public func applicationWillEnterForeground(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationWillEnterForeground(application) }
  }

  public func applicationDidEnterBackground(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationDidEnterBackground(application) }
  }

  public func applicationDidBecomeActive(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationDidBecomeActive(application) }
  }

  public func applicationWillResignActive(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationWillResignActive(application) }
  }
}

extension PluggableAppDelegate {
  public func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationProtectedDataWillBecomeUnavailable(application) }
  }

  public func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationProtectedDataDidBecomeAvailable(application) }
  }
}

extension PluggableAppDelegate {
  public func applicationWillTerminate(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationWillTerminate(application) }
  }

  public func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
    lazyServices.forEach { $0.applicationDidReceiveMemoryWarning(application) }
  }
}

extension PluggableAppDelegate {
  public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    lazyServices.forEach {
      $0.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
  }

  public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    lazyServices.forEach {
      $0.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
  }
}

extension PluggableAppDelegate {
  public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
    lazyServices.forEach {
      $0.application(application, didReceiveRemoteNotification: userInfo)
    }
  }

  public func application(_ application: UIApplication,
                          didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                          fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
  {
    lazyServices.forEach {
      $0.application(application,
                     didReceiveRemoteNotification: userInfo,
                     fetchCompletionHandler: completionHandler)
    }
  }
}

extension PluggableAppDelegate {
  public func application(_ application: UIApplication,
                          supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
  {
    UIInterfaceOrientationMask(lazyServices.map {
      $0.application(application, supportedInterfaceOrientationsFor: window)
    })
  }
}
