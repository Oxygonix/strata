import UIKit

class WorkoutLogCell: UITableViewCell {
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = 12
    }
    
    func configureButton(with image: UIImage?) {
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = 12

        if let image = image {
            if #available(iOS 15.0, *) {
                photoButton.configuration = nil
            }

            let originalImage = image.withRenderingMode(.alwaysOriginal)

            photoButton.setTitle(nil, for: .normal)
            photoButton.setImage(originalImage, for: .normal)
            photoButton.setBackgroundImage(nil, for: .normal)

            photoButton.imageView?.contentMode = .scaleAspectFill
            photoButton.contentHorizontalAlignment = .fill
            photoButton.contentVerticalAlignment = .fill
            photoButton.tintColor = nil
        } else {
            photoButton.setBackgroundImage(nil, for: .normal)
            photoButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            photoButton.setTitle(" Add Photo", for: .normal)
            photoButton.tintColor = .systemBlue
            photoButton.contentHorizontalAlignment = .center
            photoButton.contentVerticalAlignment = .center
        }
    }
}
