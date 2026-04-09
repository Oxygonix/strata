import UIKit

class AddWorkout: UIViewController {
    
    var onSave: ((_ workoutName: String, _ workoutDate: Date) -> Void)?
    
    private let accentColor = UIColor(red: 0.792, green: 0.169, blue: 0.192, alpha: 1.0)
    private let accentLight = UIColor(red: 0.92, green: 0.45, blue: 0.50, alpha: 1.0)
    private let softBackground = UIColor(red: 0.9725, green: 0.9725, blue: 0.9764, alpha: 1.0)
    
    private let backgroundGlow = UIView()
    private let cardView = UIView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nameContainer = UIView()
    private let dateLabel = UILabel()
    private let dateContainer = UIView()
    
    private let workoutNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Workout name"
        textField.borderStyle = .none
        textField.autocapitalizationType = .words
        textField.font = .systemFont(ofSize: 17, weight: .semibold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    private let createButtonGradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = softBackground
        title = "New Workout"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.rightBarButtonItem = nil
        
        setupViews()
        setupLayout()
        applyStyling()
        
        workoutNameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        updateCreateButtonState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createButtonGradient.frame = createButton.bounds
        createButtonGradient.cornerRadius = createButton.layer.cornerRadius
    }
    
    private func setupViews() {
        [backgroundGlow, cardView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [titleLabel, subtitleLabel, createButton, nameContainer, dateLabel, dateContainer].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview($0)
        }
        
        nameContainer.addSubview(workoutNameField)
        dateContainer.addSubview(datePicker)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundGlow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            backgroundGlow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundGlow.widthAnchor.constraint(equalToConstant: 240),
            backgroundGlow.heightAnchor.constraint(equalToConstant: 120),
            
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: createButton.leadingAnchor, constant: -12),
            
            createButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            createButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            createButton.widthAnchor.constraint(equalToConstant: 104),
            createButton.heightAnchor.constraint(equalToConstant: 40),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            nameContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            nameContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            nameContainer.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            nameContainer.heightAnchor.constraint(equalToConstant: 56),
            
            workoutNameField.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor, constant: 16),
            workoutNameField.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor, constant: -16),
            workoutNameField.topAnchor.constraint(equalTo: nameContainer.topAnchor),
            workoutNameField.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 22),
            dateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            dateContainer.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            dateContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            dateContainer.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            dateContainer.heightAnchor.constraint(equalToConstant: 216),
            dateContainer.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            
            datePicker.leadingAnchor.constraint(equalTo: dateContainer.leadingAnchor, constant: 8),
            datePicker.trailingAnchor.constraint(equalTo: dateContainer.trailingAnchor, constant: -8),
            datePicker.topAnchor.constraint(equalTo: dateContainer.topAnchor, constant: -8),
            datePicker.bottomAnchor.constraint(equalTo: dateContainer.bottomAnchor, constant: -8)
        ])
    }
    
    private func applyStyling() {
        titleLabel.text = "Create New Workout"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        
        subtitleLabel.text = "Choose a name and date before adding it to your log."
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        
        dateLabel.text = "Workout Date"
        dateLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        dateLabel.textColor = .secondaryLabel
        
        backgroundGlow.backgroundColor = .clear
        backgroundGlow.layer.cornerRadius = 60
        backgroundGlow.layer.masksToBounds = true
        
        let glowLayer = CAGradientLayer()
        glowLayer.frame = CGRect(x: 0, y: 0, width: 240, height: 120)
        glowLayer.colors = [
            accentColor.withAlphaComponent(0.22).cgColor,
            accentLight.withAlphaComponent(0.08).cgColor
        ]
        glowLayer.startPoint = CGPoint(x: 0, y: 0)
        glowLayer.endPoint = CGPoint(x: 1, y: 1)
        glowLayer.cornerRadius = 60
        backgroundGlow.layer.insertSublayer(glowLayer, at: 0)
        
        cardView.backgroundColor = UIColor.white.withAlphaComponent(0.82)
        cardView.layer.cornerRadius = 30
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = accentColor.withAlphaComponent(0.08).cgColor
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.08
        cardView.layer.shadowOffset = CGSize(width: 0, height: 12)
        cardView.layer.shadowRadius = 24
        
        nameContainer.layer.cornerRadius = 18
        nameContainer.layer.borderWidth = 1
        nameContainer.layer.borderColor = accentColor.withAlphaComponent(0.12).cgColor
        nameContainer.backgroundColor = accentColor.withAlphaComponent(0.06)
        
        dateContainer.layer.cornerRadius = 22
        dateContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        dateContainer.layer.borderWidth = 1
        dateContainer.layer.borderColor = accentColor.withAlphaComponent(0.10).cgColor
        dateContainer.backgroundColor = UIColor.white.withAlphaComponent(0.72)
        
        workoutNameField.textColor = .label
        workoutNameField.tintColor = accentColor
        
        navigationController?.navigationBar.tintColor = accentColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = softBackground.withAlphaComponent(0.92)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        createButtonGradient.colors = [
            accentLight.cgColor,
            accentColor.cgColor
        ]
        createButtonGradient.startPoint = CGPoint(x: 0, y: 0)
        createButtonGradient.endPoint = CGPoint(x: 1, y: 1)
        createButton.layer.insertSublayer(createButtonGradient, at: 0)
    }
    
    @objc private func textDidChange() {
        updateCreateButtonState()
    }
    
    private func updateCreateButtonState() {
        let trimmed = workoutNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let enabled = !trimmed.isEmpty
        createButton.isEnabled = enabled
        createButton.alpha = enabled ? 1.0 : 0.55
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveTapped() {
        let trimmed = workoutNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !trimmed.isEmpty else { return }
        
        onSave?(trimmed, datePicker.date)
        dismiss(animated: true)
    }
}
