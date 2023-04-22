import Foundation

public class CellModel: BaseCellModel {
  public struct PictureModel {
    let size: Picture.Size
    let image: Picture.ImagePath

    public init(
      size: Picture.Size,
      image: Picture.ImagePath
    ) {
      self.size = size
      self.image = image
    }
  }

  public enum Mode {
    case normal
    case inverted
  }

  let title: String?
  let subtitle: String?
  let picture: PictureModel?
  let mode: Mode

  public init(
    title: String?,
    subtitle: String?,
    picture: PictureModel?,
    mode: Mode = .normal
  ) {
    self.title = title
    self.subtitle = subtitle
    self.picture = picture
    self.mode = mode
  }
}
