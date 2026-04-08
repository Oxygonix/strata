import UIKit
import Charts

class WorkoutLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let activities: [WorkoutActivity] = [
        WorkoutActivity(imageName: "Male-Front", title: "Chest Workout", subtitle: "March 10, 2026 at 6:30 PM"),
        WorkoutActivity(imageName: "legs", title: "Leg Day", subtitle: "March 9, 2026 at 7:15 PM"),
        WorkoutActivity(imageName: "back", title: "Back and Biceps", subtitle: "March 8, 2026 at 5:45 PM"),
        WorkoutActivity(imageName: "run", title: "Evening Run", subtitle: "March 7, 2026 at 8:00 PM")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as? WorkoutLogCell else {
            return UITableViewCell()
        }
        
        let activity = activities[indexPath.row]
        
        cell.titleLabel.text = activity.title
        cell.subtitleLabel.text = activity.subtitle
        cell.activityImageView.image = UIImage(named: activity.imageName)
        
        return cell
    }
}
