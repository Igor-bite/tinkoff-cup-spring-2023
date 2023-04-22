import Foundation

public class BaseCellModel: Hashable {
  private let identifier = UUID()

  public func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }

  public static func == (lhs: BaseCellModel, rhs: BaseCellModel) -> Bool {
    lhs.identifier == rhs.identifier
  }
}
