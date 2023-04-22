import UIKit

@UIApplicationMain
class AppDelegate: PluggableAppDelegate {
  override func services() -> [AppService] {
    [
      EntryAppService(),
    ]
  }
}
