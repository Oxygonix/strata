import UIKit

class WorkoutLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var activities: [WorkoutActivity] = [
        WorkoutActivity(imageName: "Male-Front", title: "Chest Workout", subtitle: "March 10, 2026 at 6:30 PM", capturedImage: nil),
        WorkoutActivity(imageName: "legs", title: "Leg Day", subtitle: "March 9, 2026 at 7:15 PM", capturedImage: nil),
        WorkoutActivity(imageName: "back", title: "Back and Biceps", subtitle: "March 8, 2026 at 5:45 PM", capturedImage: nil),
        WorkoutActivity(imageName: "run", title: "Evening Run", subtitle: "March 7, 2026 at 8:00 PM", capturedImage: nil)
    ]
    
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addWorkoutTapped)
    }
    
    @objc private func addWorkoutTapped() {
        let addWorkoutVC = AddWorkout()
        
        addWorkoutVC.onSave = { [weak self] workoutName, workoutDate in
            guard let self = self else { return }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
            
            let newActivity = WorkoutActivity(
                imageName: "",
                title: workoutName,
                subtitle: formatter.string(from: workoutDate),
                capturedImage: nil
            )
            
            self.activities.insert(newActivity, at: 0)
            self.tableView.reloadData()
        }
        
        let navController = UINavigationController(rootViewController: addWorkoutVC)
        navController.modalPresentationStyle = .pageSheet
        
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        
        present(navController, animated: true)
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
        
        if let capturedImage = activity.capturedImage {
            cell.configureButton(with: capturedImage)
        } else {
            cell.configureButton(with: activity.capturedImage)
        }
        
        cell.photoButton.tag = indexPath.row
        cell.photoButton.addTarget(self, action: #selector(photoButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func photoButtonTapped(_ sender: UIButton) {
        selectedRow = sender.tag
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(
                title: "Camera Not Available",
                message: "This device does not have a camera.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let chosenImage = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        
        if let row = selectedRow, let image = chosenImage {
            activities[row].capturedImage = image
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
