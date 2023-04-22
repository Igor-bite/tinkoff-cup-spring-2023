import UIKit

public protocol Reusable: AnyObject {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  public static var reuseIdentifier: String {
    String(describing: self)
  }
}
