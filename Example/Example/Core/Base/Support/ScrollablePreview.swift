import UIKit

protocol ScrollablePreview where Self: UIViewController {
  var stack: UIStackView! { get set }
  var scroll: UIScrollView! { get set }

  func setupScroll()
  func setupStack()
  func setupContent()
}

extension ScrollablePreview {
  func setupScroll() {
    scroll = UIScrollView().autoLayout()
    view.addSubview(scroll)
    NSLayoutConstraint.activate([
      scroll.topAnchor.constraint(equalTo: view.topAnchor),
      scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }

  func setupStack() {
    stack = UIStackView().autoLayout()
    stack.axis = .vertical
    stack.alignment = .leading
    stack.distribution = .equalSpacing
    stack.spacing = 8

    scroll.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: scroll.topAnchor),
      stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -12),
      stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 12),
      stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -12),
    ])
  }
}
