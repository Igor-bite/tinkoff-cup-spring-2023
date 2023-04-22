import UIKit

public class CardCell: UICollectionViewCell, ThemeObserver, Reusable {
  internal var container = UIView().autoLayout()
  internal var picture = Picture(frame: .zero).autoLayout()
  internal var titleLabel = UILabel().autoLayout()
  internal var subtitleLabel = UILabel().autoLayout()
  internal var labelsStack = UIStackView().autoLayout()

  internal var labelsToLeading: NSLayoutConstraint?
  internal var labelsToImage: NSLayoutConstraint?

  override public var intrinsicContentSize: CGSize {
    CGSize(width: UIScreen.main.bounds.width, height: Constants.cellHeight)
  }

  private var titleTypo: Typo {
    .header.with(color: themeProvider?.colors.text.primary ?? BrandBook.Colors.Text.light.secondary)
  }

  private var subtitleTypo: Typo {
    .subheader.with(color: themeProvider?.colors.text.secondary ?? BrandBook.Colors.Text.light.secondary)
  }

  private var model: CellModel?
  internal var themeProvider: ThemeProviding?

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)

    labelsStack.axis = .vertical
    labelsStack.alignment = .leading
    labelsStack.distribution = .fill
    labelsStack.spacing = Constants.labelsSpacing

    addSubview(container)
    container.addSubview(labelsStack)
    container.addSubview(picture)

    labelsStack.addArrangedSubview(titleLabel)
    labelsStack.addArrangedSubview(subtitleLabel)

    container.layer.cornerRadius = Constants.cornerRadius
    container.layer.cornerCurve = .continuous
    container.backgroundColor = .clear

    addShadows()

    setupLayout()
  }

  private func addShadows() {
    let shadows = UIView()
    shadows.frame = container.frame
    shadows.clipsToBounds = false
    container.addSubview(shadows)

    let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 24)
    let shadowLayer = CALayer()
    shadowLayer.shadowPath = shadowPath0.cgPath
    shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
    shadowLayer.shadowOpacity = 1
    shadowLayer.shadowRadius = 34
    shadowLayer.shadowOffset = CGSize(width: 0, height: 6)
    shadowLayer.bounds = shadows.bounds
    shadowLayer.position = shadows.center
    shadows.layer.addSublayer(shadowLayer)
  }

  public func configure(
    with model: CellModel,
    themeProvider: ThemeProviding
  ) {
    self.model = model
    self.themeProvider = themeProvider

    themeProvider.addObserver(self)
    themeDidChange()

    labelsToLeading?.constant = model.picture == nil ? 12 : 52

    titleLabel.isHidden = model.title == nil
    subtitleLabel.isHidden = model.subtitle == nil

    titleLabel.attributedText = model.title?.styled(titleTypo)
    subtitleLabel.attributedText = model.subtitle?.styled(subtitleTypo)

    if let pictureModel = model.picture {
      picture.isHidden = false
      let model = PictureModel(
        size: pictureModel.size,
        imagePath: pictureModel.image,
        state: .show
      )
      picture.configure(with: model)
      labelsToLeading?.isActive = false
      labelsToImage?.isActive = true
    } else {
      picture.isHidden = true
      labelsToLeading?.isActive = true
      labelsToImage?.isActive = false
    }
  }

  internal func setupLayout() {
    container.pinEdgesToSuperview(with: .init(top: 0, left: 16, bottom: 0, right: 16))

    picture.pinTo(.top, of: container, with: Constants.padding)
    picture.pinTo(.trailing, of: container, with: -Constants.padding)
    picture.setDimensions(to: Constants.pictureSize)

    titleLabel.setDimension(.height, to: Constants.titleHeight)
    subtitleLabel.setDimension(.height, to: Constants.subtitleHeight)

    labelsStack.pinTo(.top, of: container, with: Constants.padding)
    labelsStack.pinTo(.leading, of: container, with: Constants.padding + 4)
    labelsStack.pinTo(.bottom, of: container, with: -Constants.padding - 2)
    labelsToLeading = labelsStack.pinTo(.trailing, of: container, with: Constants.padding)
    labelsToLeading?.isActive = false
    labelsToImage = labelsStack.pin(.trailing, to: .leading, of: picture, offset: Constants.spacing)
  }

  public func themeDidChange() {
    titleLabel.attributedText = model?.title?.styled(titleTypo)
    subtitleLabel.attributedText = model?.subtitle?.styled(subtitleTypo)
    container.backgroundColor = model?.mode == .inverted ? themeProvider?.colors.background.inverted : themeProvider?.colors.background.primary
  }

  override public func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
    attributes.size = intrinsicContentSize
    return attributes
  }
}

fileprivate enum Constants {
  static let cornerRadius = 24.0
  static let pictureSize = CGSize(width: 40, height: 40)
  static let cellHeight = 84.0
  static let padding = 16.0
  static let spacing = 16.0

  static let labelsSpacing = 8.0
  static let titleHeight = 24.0
  static let subtitleHeight = 18.0
}
