import UIKit

class WorkoutLogCell: UITableViewCell {
    
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityImageView.layer.cornerRadius = 8
        activityImageView.clipsToBounds = true
        activityImageView.contentMode = .scaleAspectFill
    }
}
