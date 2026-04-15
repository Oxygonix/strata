import UIKit
import FirebaseAuth
import FirebaseFirestore

class WorkoutLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let db = Firestore.firestore()
    private var activities: [WorkoutActivity] = []
    private var selectedRow: Int?
    private var isOpeningWorkout = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = #selector(addWorkoutTapped)
        
        fetchWorkoutLogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchWorkoutLogs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        isOpeningWorkout = false
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func fetchWorkoutLogs() {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .order(by: "workoutDate", descending: true)
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Failed to fetch workout logs: \(error.localizedDescription)")
                    return
                }
                
                let docs = snapshot?.documents ?? []
                self.activities = docs.compactMap { WorkoutActivity(document: $0) }
                self.tableView.reloadData()
            }
    }
    
    @objc private func addWorkoutTapped() {
        let addWorkoutVC = AddWorkout()
        
        addWorkoutVC.onWorkoutCreated = { [weak self] in
            self?.fetchWorkoutLogs()
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
        activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as? WorkoutLogCell else {
            return UITableViewCell()
        }
        
        let activity = activities[indexPath.row]
        
        cell.titleLabel.text = activity.title
        cell.subtitleLabel.text = activity.subtitle
        cell.configureButton(with: nil)
        
        cell.photoButton.tag = indexPath.row
        cell.photoButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.photoButton.addTarget(self, action: #selector(photoButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !isOpeningWorkout else { return }
        isOpeningWorkout = true
        
        let activity = activities[indexPath.row]
        
        guard let chosenWorkoutVC = storyboard?.instantiateViewController(withIdentifier: "chosenWorkout") as? ChosenWorkout else {
            isOpeningWorkout = false
            return
        }
        
        chosenWorkoutVC.workoutDocumentId = activity.id
        chosenWorkoutVC.workoutTitle = activity.title
        navigationController?.pushViewController(chosenWorkoutVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        guard let user = Auth.auth().currentUser else { return }
        
        let workout = activities[indexPath.row]
        
        db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .document(workout.id)
            .delete { [weak self] error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Failed to delete workout: \(error.localizedDescription)")
                    return
                }
                
                self.activities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
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
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
