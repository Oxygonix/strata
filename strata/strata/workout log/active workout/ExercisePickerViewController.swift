import UIKit

final class ExercisePickerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    let textField = UITextField()
    let tableView = UITableView()
    let cancelButton = UIButton(type: .system)

    var allExercises: [ExerciseData] = exercises.sorted { $0.name < $1.name }
    var filteredExercises: [ExerciseData] = []
    var onExerciseSelected: ((ExerciseData) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredExercises = allExercises

        setupView()
        setUpTextField()
        setUpTableView()
        setUpCancelButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let safe = view.safeAreaInsets
        let padding: CGFloat = 16

        cancelButton.frame = CGRect(
            x: padding,
            y: safe.top + 8,
            width: 80,
            height: 36
        )

        textField.frame = CGRect(
            x: padding,
            y: cancelButton.frame.maxY + 12,
            width: view.bounds.width - (padding * 2),
            height: 50
        )

        tableView.frame = CGRect(
            x: 0,
            y: textField.frame.maxY + 12,
            width: view.bounds.width,
            height: view.bounds.height - textField.frame.maxY - 12
        )
    }

    private func setupView() {
        view.backgroundColor = .systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.text = "Add Exercise"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setUpTextField() {
        textField.placeholder = "Search exercises"
        textField.borderStyle = .none
        textField.backgroundColor = .secondarySystemGroupedBackground
        textField.layer.cornerRadius = 18
        textField.layer.masksToBounds = true
        textField.font = .systemFont(ofSize: 17, weight: .medium)
        textField.textColor = .label
        textField.tintColor = .systemRed
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

        let leftPad = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 50))
        textField.leftView = leftPad
        textField.leftViewMode = .always

        view.addSubview(textField)
    }

    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 24, right: 0)
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 92

        view.addSubview(tableView)
    }

    private func setUpCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        cancelButton.setTitleColor(.systemRed, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }

    @objc private func textDidChange() {
        let query = textField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased() ?? ""

        if query.isEmpty {
            filteredExercises = allExercises
        } else {
            filteredExercises = allExercises.filter {
                $0.name.lowercased().contains(query)
            }
        }

        tableView.reloadData()
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if filteredExercises.count == 1 {
            selectExercise(filteredExercises[0])
        }
        textField.resignFirstResponder()
        return true
    }

    private func selectExercise(_ exercise: ExerciseData) {
        onExerciseSelected?(exercise)
        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredExercises.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectExercise(filteredExercises[indexPath.row])
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        92
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = filteredExercises[indexPath.row]

        let muscleText = exercise.muscles
            .sorted { $0.value > $1.value }
            .map { $0.key.replacingOccurrences(of: "_", with: " ").capitalized }
            .prefix(3)
            .joined(separator: ", ")

        var content = UIListContentConfiguration.subtitleCell()
        content.text = exercise.name
        content.secondaryText = muscleText
        content.image = UIImage(systemName: iconName(for: exercise.name, muscles: exercise.muscles))
        content.imageProperties.tintColor = .systemRed
        content.imageProperties.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)

        content.textProperties.font = .systemFont(ofSize: 20, weight: .semibold)
        content.textProperties.color = .label

        content.secondaryTextProperties.font = .systemFont(ofSize: 15, weight: .medium)
        content.secondaryTextProperties.color = .secondaryLabel

        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 18)
        cell.contentConfiguration = content

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = .secondarySystemGroupedBackground
        background.cornerRadius = 22
        background.strokeColor = UIColor.separator.withAlphaComponent(0.15)
        background.strokeWidth = 1
        cell.backgroundConfiguration = background

        cell.backgroundColor = .clear
        cell.clipsToBounds = false

        return cell
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }

    private func iconName(for exerciseName: String, muscles: [String: Int]) -> String {
        let name = exerciseName.lowercased()
        let keys = Set(muscles.keys.map { $0.lowercased() })

        if name.contains("chest") || keys.contains("chest") || name.contains("press") || name.contains("fly") {
            return "figure.strengthtraining.traditional"
        }

        if name.contains("back") || keys.contains("back") || keys.contains("lats") || keys.contains("traps") || name.contains("row") || name.contains("pull") {
            return "figure.rower"
        }

        if name.contains("leg") || keys.contains("quads") || keys.contains("hamstrings") || keys.contains("glutes") || keys.contains("calves") {
            return "figure.run"
        }

        if name.contains("curl") || name.contains("tricep") || name.contains("bicep") || keys.contains("biceps") || keys.contains("triceps") || keys.contains("forearms") {
            return "dumbbell"
        }

        if name.contains("ab") || name.contains("core") || keys.contains("abs") || keys.contains("core") || keys.contains("obliques") {
            return "figure.core.training"
        }

        if keys.contains("shoulders") || name.contains("shoulder") || name.contains("lateral raise") || name.contains("overhead") {
            return "figure.strengthtraining.functional"
        }

        return "bolt.heart.fill"
    }
}
