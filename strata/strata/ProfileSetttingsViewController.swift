//
//  ProfileSetttingsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit
import UserNotifications
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileSetttingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightFtTextField: UITextField!
    @IBOutlet weak var heightInTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var benchButton: UIButton!
    @IBOutlet weak var barbellsButton: UIButton!
    @IBOutlet weak var kettlebellButton: UIButton!
    @IBOutlet weak var dumbbellsButton: UIButton!
    @IBOutlet weak var matButton: UIButton!
    @IBOutlet weak var cablesButton: UIButton!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var benchSelected = false
    var barbellsSelected = false
    var kettlebellSelected = false
    var dumbbellsSelected = false
    var matSelected = false
    var cablesSelected = false
    var sex = "male"
    
    var onProfileUpdated: (() -> Void)?
    var pendingProfileImage: UIImage?
    var cameFromSignup = false
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never

        let titleLabel = UILabel()
        titleLabel.text = cameFromSignup ? "Set Profile" : "Edit Profile"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel

        loadProfileImage()
        updateSexButtons()

        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProfileData()
    }
    
    @IBAction func equipmentButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        let imageName = sender.isSelected ? "checkmark.square.fill" : "square"
        sender.setImage(UIImage(systemName: imageName), for: .normal)

        switch sender {
        case benchButton:
            benchSelected = sender.isSelected
        case barbellsButton:
            barbellsSelected = sender.isSelected
        case kettlebellButton:
            kettlebellSelected = sender.isSelected
        case dumbbellsButton:
            dumbbellsSelected = sender.isSelected
        case matButton:
            matSelected = sender.isSelected
        case cablesButton:
            cablesSelected = sender.isSelected
        default:
            break
        }
    }
    
    func saveProfileToFirestore() {
        guard let user = Auth.auth().currentUser else {
            print("NOT GETTING PAST GUARD")
            return
        }

        let name = nameTextField.text ?? ""
        let age = Int(ageTextField.text ?? "") ?? 0
        let heightFt = Int(heightFtTextField.text ?? "") ?? 0
        let heightIn = Int(heightInTextField.text ?? "") ?? 0
        let weight = Int(weightTextField.text ?? "") ?? 0

        db.collection("users").document(user.uid).setData([
            "name": name,
            "firstTime": cameFromSignup,
            "age": age,
            "height": [
                "ft": heightFt,
                "in": heightIn
            ],
            "sex": sex,
            "weight": weight,
            "equipment": [
                "bench": benchSelected,
                "barbells": barbellsSelected,
                "kettlebell": kettlebellSelected,
                "dumbbells": dumbbellsSelected,
                "mat": matSelected,
                "cables": cablesSelected
            ],
        ], merge: true)
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        saveProfileToFirestore()

        let finishNavigation = {
            print("cameFromSignup =", self.cameFromSignup)
            self.onProfileUpdated?()

            if self.cameFromSignup {
                self.goToHeatMap()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }

        if let image = pendingProfileImage {
            uploadImageToFirebase(image: image) { success in
                DispatchQueue.main.async {
                    if !success {
                        print("Image upload failed, but profile info was saved.")
                    }

                    self.pendingProfileImage = nil
                    finishNavigation()
                }
            }
        } else {
            finishNavigation()
        }
    }
    
    private func goToHeatMap() {
        let storyboard = UIStoryboard(name: "HeatMap", bundle: nil)
        let heatMapNav = storyboard.instantiateViewController(withIdentifier: "HeatMapNavBar")

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }

        sceneDelegate.window?.rootViewController = heatMapNav
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func maleButtonPushed(_ sender: Any) {
        sex = "male"
        updateSexButtons()
    }
    
    @IBAction func femaleButtonPushed(_ sender: Any) {
        sex = "female"
        updateSexButtons()
    }
    
    func updateSexButtons() {
        var maleConfig = maleButton.configuration ?? UIButton.Configuration.filled()
        maleConfig.title = "Male"
        maleConfig.image = UIImage(systemName: "figure.stand")
        maleConfig.imagePlacement = .leading
        maleConfig.imagePadding = 8
        maleConfig.cornerStyle = .large
        maleConfig.baseBackgroundColor = (sex == "male") ? .systemRed : .systemGray6
        maleConfig.baseForegroundColor = (sex == "male") ? .white : .label
        maleButton.configuration = maleConfig

        var femaleConfig = femaleButton.configuration ?? UIButton.Configuration.filled()
        femaleConfig.title = "Female"
        femaleConfig.image = UIImage(systemName: "figure.stand.dress")
        femaleConfig.imagePlacement = .leading
        femaleConfig.imagePadding = 8
        femaleConfig.cornerStyle = .large
        femaleConfig.baseBackgroundColor = (sex == "female") ? .systemRed : .systemGray6
        femaleConfig.baseForegroundColor = (sex == "female") ? .white : .label
        femaleButton.configuration = femaleConfig
    }
    
    func updateEquipmentButtons() {
        let equipmentStates = [
            benchButton: benchSelected,
            barbellsButton: barbellsSelected,
            kettlebellButton: kettlebellSelected,
            dumbbellsButton: dumbbellsSelected,
            matButton: matSelected,
            cablesButton: cablesSelected
        ]
        
        for (button, isSelected) in equipmentStates {
            let imageName = isSelected ? "checkmark.square.fill" : "square"
            button?.setImage(UIImage(systemName: imageName), for: .normal)
            button?.isSelected = isSelected
        }
    }
    
    @IBAction func changePhotoPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
            
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImage.image = selectedImage
            pendingProfileImage = selectedImage
            print("Image selected and waiting to save on Done")
        }
        
        dismiss(animated: true)
    }
    
    func uploadImageToFirebase(image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { completion(false); return }
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { completion(false); return }

        let storageRef = Storage.storage().reference().child("profile_images/\(userID).jpg")

        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Upload error: \(error.localizedDescription)")
                completion(false)
                return
            }

            storageRef.downloadURL { url, error in
                if let downloadURL = url {
                    self.saveImageURLToFirestore(url: downloadURL.absoluteString) { success in
                        completion(success)
                    }
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func saveImageURLToFirestore(url: String, completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { completion(false); return }

        Firestore.firestore().collection("users").document(userID).setData([
            "profileImageURL": url
        ], merge: true) { error in
            if let error = error {
                print("Firestore save error: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Profile image URL saved successfully")
                completion(true)
            }
        }
    }
    
    func saveProfileImageToFirestore(image: UIImage) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let base64String = imageData.base64EncodedString()
        
        Firestore.firestore().collection("users").document(userID).setData([
            "profileImageBase64": base64String
        ], merge: true) { error in
            if let error = error {
                print("Error saving image: \(error.localizedDescription)")
            } else {
                print("Profile image saved in Firestore successfully")
            }
        }
    }
    
    func loadProfileImage() {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("No logged in user to load image")
            return
        }

        let docRef = Firestore.firestore().collection("users").document(userID)
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  let urlString = data["profileImageURL"] as? String,
                  let url = URL(string: urlString) else {
                return
            }

            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }

                DispatchQueue.main.async {
                    self.profileImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    func loadProfileData() {
        guard let user = Auth.auth().currentUser else {
            print("No logged in user")
            return
        }
        
        let docRef = db.collection("users").document(user.uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                
                self.nameTextField.text = data["name"] as? String ?? ""
                
                if let age = data["age"] as? Int {
                    self.ageTextField.text = "\(age)"
                } else {
                    self.ageTextField.text = ""
                }
                
                if let height = data["height"] as? [String: Any] {
                    let ft = height["ft"] as? Int ?? 0
                    let inch = height["in"] as? Int ?? 0
                    self.heightFtTextField.text = "\(ft)"
                    self.heightInTextField.text = "\(inch)"
                } else {
                    self.heightFtTextField.text = ""
                    self.heightInTextField.text = ""
                }
                
                if let weight = data["weight"] as? Int {
                    self.weightTextField.text = "\(weight)"
                } else {
                    self.weightTextField.text = ""
                }
                
                if let equipment = data["equipment"] as? [String: Bool] {
                    self.benchSelected = equipment["bench"] ?? false
                    self.barbellsSelected = equipment["barbells"] ?? false
                    self.kettlebellSelected = equipment["kettlebell"] ?? false
                    self.dumbbellsSelected = equipment["dumbbells"] ?? false
                    self.matSelected = equipment["mat"] ?? false
                    self.cablesSelected = equipment["cables"] ?? false
                    self.updateEquipmentButtons()
                }
                
                if let savedSex = data["sex"] as? String {
                    self.sex = savedSex
                    self.updateSexButtons()
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
}
