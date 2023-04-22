import UIKit

open class BaseTableCell: UITableViewCell, Reusable {
  override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }

  open func setupViews() {}
}

open class BaseCollectionCell: UICollectionViewCell, Reusable {
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }

  open func setupViews() {}
}
