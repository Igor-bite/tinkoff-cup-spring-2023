import DesignSystem
import UIKit

protocol ScrollableStackPreview where Self: UIViewController {
  var stack: UIStackView! { get set }
  var scroll: UIScrollView! { get set }

  func setupScroll()
  func setupStack()
  func setupContent()
}

extension ScrollableStackPreview {
  func setupScroll() {
    scroll = UIScrollView().autoLayout()
    view.addSubview(scroll)
    scroll.pinEdgesToSuperview()
  }

  func setupStack() {
    stack = UIStackView().autoLayout()
    stack.axis = .vertical
    stack.alignment = .leading
    stack.distribution = .equalSpacing
    stack.spacing = 8

    let offset: CGFloat = 20

    scroll.addSubview(stack)
    stack.pinTo(.leading, of: scroll, with: offset)
    stack.pinTo(.top, of: scroll)
    stack.pinTo(.bottom, of: scroll)
    stack.setDimension(.width, equalTo: .width, of: scroll, with: -(offset * 2))
  }
}
