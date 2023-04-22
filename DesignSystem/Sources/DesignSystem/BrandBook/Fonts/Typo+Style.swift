import UIKit

extension Typo {
  public static let header: Typo = .init(
    //    font: UIFont(name: "SFProDisplay-Bold", size: 20),
    font: .systemFont(ofSize: 20, weight: .bold),
    lineHeight: 23.87
  )

  public static let subheader: Typo = .init(
    font: .systemFont(ofSize: 15),
    lineHeight: 17.9
  )

  public static let actionText: Typo = .init(
    font: .systemFont(ofSize: 15),
    lineHeight: 17.9
  )

  public static let title: Typo = .init(
    font: .systemFont(ofSize: 17),
    lineHeight: 20.29
  )

  public static let subtitle: Typo = .init(
    font: .systemFont(ofSize: 13),
    lineHeight: 15.51
  )
}
