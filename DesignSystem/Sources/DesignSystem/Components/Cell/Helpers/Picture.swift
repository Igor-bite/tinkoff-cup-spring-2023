import UIKit

public struct PictureModel {
  let size: Picture.Size
  let imagePath: Picture.ImagePath
  var state: Picture.State? = .loading
  var customColor: Color?

  public init(
    size: Picture.Size,
    imagePath: Picture.ImagePath,
    state: Picture.State? = .loading,
    customColor: Color? = nil
  ) {
    self.size = size
    self.imagePath = imagePath
    self.state = state
    self.customColor = customColor
  }
}

public class Picture: UIView {
  public enum ImagePath {
    case image(UIImage)
    case remote(URL)
  }

  public enum Size {
    case l
    case s
    case custom(CGFloat)
  }

  public enum State {
    case initial
    case loading
    case show
    case failed
  }

  private var size: Size = .l
  private var imagePath: ImagePath?
  private var state: State = .initial {
    didSet {
      switch state {
      case .initial:
        imageView.isHidden = true
      case .loading:
        imageView.isHidden = true
      case .failed:
        imageView.isHidden = true
      case .show:
        imageView.isHidden = false
      }
    }
  }

  private var imageView = LoadableImageView().autoLayout()
  private var customColor: Color?
  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(imageView)

    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true

    setupLayout()
  }

  public func configure(with model: PictureModel) {
    self.state = model.state ?? .show
    self.imagePath = model.imagePath
    self.size = model.size
    self.customColor = model.customColor

    loadImage()
    updateLayout()
  }

  public func updateColor(_ color: Color) {
    customColor = color
  }

  override public var intrinsicContentSize: CGSize {
    switch size {
    case .l:
      return CGSize(width: 40, height: 40)
    case .s:
      return CGSize(width: 24, height: 24)
    case let .custom(value):
      return CGSize(width: value, height: value)
    }
  }

  private func updateLayout() {
    widthConstraint?.constant = intrinsicContentSize.width
    heightConstraint?.constant = intrinsicContentSize.height
  }

  private func setupLayout() {
    imageView.pinEdgesToSuperview()

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: 10)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: 10)

    NSLayoutConstraint.activate([
      widthConstraint,
      heightConstraint,
    ])

    self.widthConstraint = widthConstraint
    self.heightConstraint = heightConstraint
  }

  private func loadImage() {
    guard let imagePath else { return }

    switch imagePath {
    case let .image(image):
      imageView.image = image
    case let .remote(url):
      imageView.load(fromUrl: url)
    }
  }
}
