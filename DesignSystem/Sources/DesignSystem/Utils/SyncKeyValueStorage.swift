import Foundation

public protocol SyncKeyValueStorage {
  func integer(forKey defaultName: String) -> Int
  func double(forKey defaultName: String) -> Double
  func string(forKey defaultName: String) -> String?
  func data(forKey defaultName: String) -> Data?
  func bool(forKey defaultName: String) -> Bool
  func bool(forKey defaultName: String, defaultValue: Bool) -> Bool
  func object(forKey defaultName: String) -> Any?

  func set(_ value: Any?, forKey defaultName: String)
  func set(_ value: Int, forKey defaultName: String)
  func set(_ value: Bool, forKey defaultName: String)

  func removeObject(forKey defaultName: String)
}
