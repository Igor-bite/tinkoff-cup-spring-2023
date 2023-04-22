import DesignSystem
import UIKit

public class ComponentsController: UIViewController, ThemeSwitchable {
  var themeProvider: ThemeStore

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).autoLayout()
    collectionView.register(cellType: PrimitiveCell.self)
    collectionView.register(cellType: CardCell.self)
    collectionView.dataSource = self
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()

  public init(
    themeProvider: ThemeStore
  ) {
    self.themeProvider = themeProvider

    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override public func viewDidLoad() {
    super.viewDidLoad()

    title = "Components"
    navigationController?.navigationBar.prefersLargeTitles = true

    setupUI()
    addSwitchButton()

    themeProvider.addObserver(self)
    setTheme(themeProvider.currentThemeSetting)
  }
}

// MARK: Setup

extension ComponentsController {
  fileprivate func setupUI() {
    setupCollectionView()
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
  }

  fileprivate func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.pinEdgesToSuperview()
  }
}

// MARK: ThemeObserver

extension ComponentsController: ThemeObserver {
  public func themeDidChange() {
    collectionView.backgroundColor = .clear
    view.backgroundColor = themeProvider.currentTheme == .light ? .white : .black
  }
}

extension ComponentsController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    8
  }

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.item {
    case 0 ... 1:
      let cell: PrimitiveCell = collectionView.dequeueReusableCell(for: indexPath)
      let picture = CellModel.PictureModel(size: .l, image: .image(.init(named: "picture")!))
      let mode: CellModel.Mode = indexPath.item % 2 == 0 ? .normal : .inverted
      let model = CellModel(title: "Title", subtitle: "Description", picture: picture, mode: mode)
      cell.configure(with: model, themeProvider: themeProvider)
      return cell
    case 2 ... 3:
      let cell: PrimitiveCell = collectionView.dequeueReusableCell(for: indexPath)
      let picture = CellModel.PictureModel(size: .l, image: .image(.init(named: "picture")!))
      let mode: CellModel.Mode = indexPath.item % 2 == 0 ? .normal : .inverted
      let model = CellModel(title: "Title", subtitle: nil, picture: picture, mode: mode)
      cell.configure(with: model, themeProvider: themeProvider)
      return cell
    case 4 ... 5:
      let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
      let picture = CellModel.PictureModel(size: .l, image: .image(.init(named: "picture")!))
      let mode: CellModel.Mode = indexPath.item % 2 == 0 ? .normal : .inverted
      let model = CellModel(title: "Header", subtitle: nil, picture: picture, mode: mode)
      cell.configure(with: model, themeProvider: themeProvider)
      return cell
    case 6 ... 7:
      let cell: CardCell = collectionView.dequeueReusableCell(for: indexPath)
      let picture = CellModel.PictureModel(size: .l, image: .image(.init(named: "picture")!))
      let mode: CellModel.Mode = indexPath.item % 2 == 0 ? .normal : .inverted
      let model = CellModel(title: "Header", subtitle: "Subheader", picture: picture, mode: mode)
      cell.configure(with: model, themeProvider: themeProvider)
      return cell
    default:
      return .init()
    }
  }
}
