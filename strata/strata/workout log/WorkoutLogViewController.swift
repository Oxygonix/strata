import UIKit
import FirebaseAuth
import FirebaseFirestore

class WorkoutLogViewController: UIViewController,
                                UITableViewDataSource,
                                UITableViewDelegate,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let db = Firestore.firestore()
    private var activities: [WorkoutActivity] = []
    private var selectedRow: Int?
    private var selectedWorkoutId: String?
    private var isOpeningWorkout = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()
        titleLabel.text = "Workout Log"
        
        navigationItem.titleView = titleLabel
        
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
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "WorkoutCell",
            for: indexPath
        ) as? WorkoutLogCell else {
            return UITableViewCell()
        }
        
        let activity = activities[indexPath.row]
        
        cell.titleLabel.text = activity.title
        cell.subtitleLabel.text = activity.subtitle
        

        if let base64 = activity.workoutImageBase64,
           let imageData = Data(base64Encoded: base64),
           let image = UIImage(data: imageData) {
            cell.configureButton(with: image)
        } else {
            cell.configureButton(with: nil)
        }
        
        cell.photoButton.removeTarget(nil, action: nil, for: .allEvents)
        cell.photoButton.addTarget(
            self,
            action: #selector(photoButtonTapped(_:)),
            for: .touchUpInside
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        guard !isOpeningWorkout else { return }
        isOpeningWorkout = true
        
        let activity = activities[indexPath.row]
        
        guard let chosenWorkoutVC = storyboard?.instantiateViewController(
            withIdentifier: "chosenWorkout"
        ) as? ChosenWorkout else {
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
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        
        guard let indexPath = tableView.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        selectedRow = indexPath.row
        selectedWorkoutId = activities[indexPath.row].id
        
        let alert = UIAlertController(
            title: "Add Workout Photo",
            message: "Choose how you want to add a photo.",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { [weak self] _ in
            self?.openImagePicker(sourceType: .camera)
        })
        
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default) { [weak self] _ in
            self?.openImagePicker(sourceType: .photoLibrary)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
        }
        
        present(alert, animated: true)
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            let alert = UIAlertController(
                title: "Source Not Available",
                message: "This option is not available on this device.",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = (info[.editedImage] as? UIImage) ??
                                  (info[.originalImage] as? UIImage),
              let workoutId = selectedWorkoutId,
              let user = Auth.auth().currentUser else {
            picker.dismiss(animated: true)
            return
        }
        
        switch encodeWorkoutImage(selectedImage) {
        case .success(let base64):
            db.collection("users")
                .document(user.uid)
                .collection("WorkoutLogs")
                .document(workoutId)
                .setData([
                    "workoutImageBase64": base64,
                    "updatedAt": FieldValue.serverTimestamp()
                ], merge: true) { [weak self] error in
                    
                    if let error = error {
                        print("Failed to save workout image: \(error.localizedDescription)")
                        return
                    }
                    
                    print("Workout image saved for workout document: \(workoutId)")
                    
                    DispatchQueue.main.async {
                        self?.fetchWorkoutLogs()
                    }
                }
            
        case .failure(let error):
            print("Could not encode workout image: \(error.localizedDescription)")
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func encodeWorkoutImage(_ image: UIImage) -> Result<String, Error> {
        let resized = image.resizedToFit(maxDimension: 400)
        
        var quality: CGFloat = 0.7
        var data = resized.jpegData(compressionQuality: quality)
        
        /*
         Firestore documents must stay under 1 MB total.
         Base64 makes the image string larger, so keep the JPEG small.
        */
        let maxJPEGBytes = 700_000
        
        while let current = data, current.count > maxJPEGBytes, quality > 0.1 {
            quality -= 0.1
            data = resized.jpegData(compressionQuality: quality)
        }
        
        guard let finalData = data else {
            return .failure(NSError(
                domain: "WorkoutImage",
                code: 422,
                userInfo: [
                    NSLocalizedDescriptionKey: "Could not encode image as JPEG."
                ]
            ))
        }
        
        print("Encoded workout image: \(finalData.count) bytes at quality \(quality)")
        
        return .success(finalData.base64EncodedString())
    }
}

private extension UIImage {
    func resizedToFit(maxDimension: CGFloat) -> UIImage {
        let longest = max(size.width, size.height)
        guard longest > maxDimension else { return self }
        
        let scale = maxDimension / longest
        let newSize = CGSize(
            width: size.width * scale,
            height: size.height * scale
        )
        
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
