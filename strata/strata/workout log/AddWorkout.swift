import UIKit

class AddWorkout: UIViewController {
    
    var onSave: ((_ workoutName: String, _ workoutDate: Date) -> Void)?
    
    private let workoutNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Workout name"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Workout Date"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTapped))
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Add Workout"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.rightBarButtonItem = saveButton
        
        setupLayout()
        workoutNameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func setupLayout() {
        view.addSubview(workoutNameField)
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            workoutNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            workoutNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            workoutNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            workoutNameField.heightAnchor.constraint(equalToConstant: 44),
            
            dateLabel.topAnchor.constraint(equalTo: workoutNameField.bottomAnchor, constant: 28),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func textDidChange() {
        let trimmedText = workoutNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        saveButton.isEnabled = !trimmedText.isEmpty
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        let trimmedText = workoutNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !trimmedText.isEmpty else { return }
        
        onSave?(trimmedText, datePicker.date)
        dismiss(animated: true)
    }
}
