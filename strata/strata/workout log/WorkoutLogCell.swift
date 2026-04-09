import UIKit

class WorkoutLogCell: UITableViewCell {
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = 12
        
        if #available(iOS 15.0, *) {
            photoButton.configuration?.imagePadding = 8
        }
    }
    
    func configureButton(with image: UIImage?) {
        if let image = image {
            photoButton.setImage(nil, for: .normal)
            photoButton.setBackgroundImage(image, for: .normal)
            photoButton.setTitle("", for: .normal)
        } else {
            photoButton.setBackgroundImage(nil, for: .normal)
            photoButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            photoButton.setTitle(" Add Photo", for: .normal)
        }
    }
}
