//
//  WorkoutDetailViewController.swift
//  strata
//
//  Created by Sanjana Madhav on 4/3/26.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WorkoutDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var workout: Workout?

    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var bodyPartsWorkedLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private let db = Firestore.firestore()
    private let bottomButtonContainer = UIView()
    private let addToWorkoutLogButton = UIButton(type: .system)

    private let summaryCardView = UIView()
    private let summaryStackView = UIStackView()

    private let bodyPartsTitleLabel = UILabel()
    private let bodyPartsValueLabel = UILabel()

    private let difficultyTitleLabel = UILabel()
    private let difficultyValueLabel = UILabel()

    private let durationTitleLabel = UILabel()
    private let durationValueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSummaryCard()
        setupTableView()
        setupBottomButton()
        populateWorkoutInfo()
    }

    private func setupView() {
        view.backgroundColor = .systemGroupedBackground

        let titleLabel = UILabel()
        titleLabel.text = workout?.name ?? "Workout"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.prefersLargeTitles = false

        workoutLabel.isHidden = true
        bodyPartsWorkedLabel.isHidden = true
        difficultyLevelLabel.isHidden = true
        durationLabel.isHidden = true
    }

    private func setupSummaryCard() {
        summaryCardView.translatesAutoresizingMaskIntoConstraints = false
        summaryCardView.backgroundColor = .secondarySystemGroupedBackground
        summaryCardView.layer.cornerRadius = 24
        summaryCardView.layer.cornerCurve = .continuous
        summaryCardView.layer.borderWidth = 1
        summaryCardView.layer.borderColor = UIColor.separator.withAlphaComponent(0.10).cgColor
        summaryCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.04).cgColor
        summaryCardView.layer.shadowOpacity = 1
        summaryCardView.layer.shadowRadius = 12
        summaryCardView.layer.shadowOffset = CGSize(width: 0, height: 4)

        view.addSubview(summaryCardView)

        NSLayoutConstraint.activate([
            summaryCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            summaryCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            summaryCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])

        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 18
        summaryStackView.alignment = .fill
        summaryStackView.distribution = .fill

        summaryCardView.addSubview(summaryStackView)

        NSLayoutConstraint.activate([
            summaryStackView.topAnchor.constraint(equalTo: summaryCardView.topAnchor, constant: 22),
            summaryStackView.leadingAnchor.constraint(equalTo: summaryCardView.leadingAnchor, constant: 22),
            summaryStackView.trailingAnchor.constraint(equalTo: summaryCardView.trailingAnchor, constant: -22),
            summaryStackView.bottomAnchor.constraint(equalTo: summaryCardView.bottomAnchor, constant: -22)
        ])

        let bodyPartsRow = makeInfoRow(titleLabel: bodyPartsTitleLabel, valueLabel: bodyPartsValueLabel)
        let difficultyRow = makeInfoRow(titleLabel: difficultyTitleLabel, valueLabel: difficultyValueLabel)
        let durationRow = makeInfoRow(titleLabel: durationTitleLabel, valueLabel: durationValueLabel)

        summaryStackView.addArrangedSubview(bodyPartsRow)
        summaryStackView.addArrangedSubview(difficultyRow)
        summaryStackView.addArrangedSubview(durationRow)

        bodyPartsTitleLabel.text = "BODY PARTS WORKED"
        difficultyTitleLabel.text = "DIFFICULTY LEVEL"
        durationTitleLabel.text = "DURATION"
    }

    private func makeInfoRow(titleLabel: UILabel, valueLabel: UILabel) -> UIView {
        let container = UIView()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        titleLabel.textColor = .secondaryLabel

        let titleKerning = NSMutableAttributedString(string: titleLabel.text ?? "")
        titleKerning.addAttribute(.kern, value: 0.8, range: NSRange(location: 0, length: titleKerning.length))
        titleLabel.attributedText = titleKerning

        valueLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        valueLabel.textColor = .label
        valueLabel.numberOfLines = 0

        container.addSubview(titleLabel)
        container.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])

        return container
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 124
        tableView.contentInset = UIEdgeInsets(top: 135, left: 0, bottom: 110, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 135, left: 0, bottom: 110, right: 0)
    }

    private func setupBottomButton() {
        bottomButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonContainer.backgroundColor = .clear

        addToWorkoutLogButton.translatesAutoresizingMaskIntoConstraints = false
        addToWorkoutLogButton.setTitle("Add to Workout Log", for: .normal)
        addToWorkoutLogButton.setTitleColor(.systemRed, for: .normal)
        addToWorkoutLogButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        addToWorkoutLogButton.backgroundColor = .secondarySystemGroupedBackground
        addToWorkoutLogButton.layer.cornerRadius = 20
        addToWorkoutLogButton.layer.cornerCurve = .continuous
        addToWorkoutLogButton.layer.borderWidth = 1
        addToWorkoutLogButton.layer.borderColor = UIColor.separator.withAlphaComponent(0.12).cgColor
        addToWorkoutLogButton.layer.shadowColor = UIColor.black.withAlphaComponent(0.05).cgColor
        addToWorkoutLogButton.layer.shadowOpacity = 1
        addToWorkoutLogButton.layer.shadowRadius = 10
        addToWorkoutLogButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        addToWorkoutLogButton.tintColor = .systemRed

        let plusImage = UIImage(systemName: "plus")
        addToWorkoutLogButton.setImage(plusImage, for: .normal)
        addToWorkoutLogButton.semanticContentAttribute = .forceLeftToRight
        addToWorkoutLogButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 6)

        addToWorkoutLogButton.addTarget(self, action: #selector(addToWorkoutLogTapped), for: .touchUpInside)

        view.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(addToWorkoutLogButton)

        NSLayoutConstraint.activate([
            bottomButtonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bottomButtonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),

            addToWorkoutLogButton.topAnchor.constraint(equalTo: bottomButtonContainer.topAnchor),
            addToWorkoutLogButton.leadingAnchor.constraint(equalTo: bottomButtonContainer.leadingAnchor),
            addToWorkoutLogButton.trailingAnchor.constraint(equalTo: bottomButtonContainer.trailingAnchor),
            addToWorkoutLogButton.bottomAnchor.constraint(equalTo: bottomButtonContainer.bottomAnchor),
            addToWorkoutLogButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func populateWorkoutInfo() {
        bodyPartsValueLabel.text = workout?.bodyPartsWorked.joined(separator: ", ") ?? "Unknown"
        difficultyValueLabel.text = workout?.difficulty ?? "Unknown"
        durationValueLabel.text = workout.map { "\($0.duration) mins" } ?? "Unknown"

        tableView.reloadData()
    }

    private func intensityText(for value: Int) -> String {
        switch value {
        case 1: return "Very Light"
        case 2: return "Light"
        case 3: return "Moderate"
        case 4: return "Hard"
        case 5: return "Very Hard"
        default: return "Unknown"
        }
    }

    @objc private func addToWorkoutLogTapped() {
        guard let workout = workout else { return }
        guard let user = Auth.auth().currentUser else { return }

        addToWorkoutLogButton.isEnabled = false

        let workoutDate = Date()
        let exercisesPayload = workout.exercises.map { exercise -> [String: Any] in
            [
                "name": exercise.name,
                "muscles": realMusclesDictionary(for: exercise),
                "sets": defaultSets(for: exercise).map { $0.dictionary },
                "intensity": exercise.intensity
            ]
        }

        let payload: [String: Any] = [
            "title": workout.name,
            "workoutDate": Timestamp(date: workoutDate),
            "difficulty": workout.difficulty,
            "duration": workout.duration,
            "bodyPartsWorked": workout.bodyPartsWorked,
            "exercises": exercisesPayload
        ]

        let docRef = db.collection("users")
            .document(user.uid)
            .collection("WorkoutLogs")
            .document()

        docRef.setData(payload) { [weak self] error in
            guard let self = self else { return }

            self.addToWorkoutLogButton.isEnabled = true

            if let error = error {
                print("Failed to create workout log: \(error.localizedDescription)")
                return
            }

            //Switch tab bars when add to workout log selected
            guard let tabBarController = self.tabBarController else {
                        print("No tab bar controller found")
                        return
                    }

                    let workoutLogTabIndex = 1

                    if let viewControllers = tabBarController.viewControllers,
                       viewControllers.indices.contains(workoutLogTabIndex) {

                        // Remove recommendations detail screen from its nav stack
                        self.navigationController?.popToRootViewController(animated: false)

                        // Switch to the actual Workout Log tab
                        tabBarController.selectedIndex = workoutLogTabIndex
                    }
        }
    }

    private func defaultSets(for exercise: Exercise) -> [WorkoutSet] {
        let repValue = defaultRepValue(from: exercise.reps)

        return (0..<exercise.sets).map { _ in
            WorkoutSet(weight: 0, reps: repValue)
        }
    }

    private func defaultRepValue(from repsText: String) -> Int {
        let numbers = repsText
            .split { !$0.isNumber }
            .compactMap { Int($0) }

        return numbers.first ?? 0
    }

    private func realMusclesDictionary(for exercise: Exercise) -> [String: Int] {
        if let match = exercises.first(where: { $0.name == exercise.name }) {
            return match.muscles
        }

        print("Warning: No ExerciseData match found for \(exercise.name)")
        return [:]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout?.exercises.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)

        guard let exercise = workout?.exercises[indexPath.row] else {
            return cell
        }

        var content = UIListContentConfiguration.subtitleCell()
        content.text = exercise.name
        content.secondaryText = "\(exercise.sets) sets • \(exercise.reps) reps • Rest: \(exercise.rest)\n\(intensityText(for: exercise.intensity)) (\(exercise.intensity)/5)"
        content.image = UIImage(systemName: iconName(for: exercise.name))

        content.imageProperties.tintColor = .systemRed
        content.imageProperties.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 18,
            weight: .semibold
        )

        content.textProperties.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        content.textProperties.color = .label

        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        content.secondaryTextProperties.color = .secondaryLabel
        content.secondaryTextProperties.numberOfLines = 2

        content.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 18,
            leading: 18,
            bottom: 18,
            trailing: 18
        )

        cell.contentConfiguration = content

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = .secondarySystemGroupedBackground
        background.cornerRadius = 22
        background.strokeWidth = 1
        background.strokeColor = UIColor.separator.withAlphaComponent(0.12)
        cell.backgroundConfiguration = background

        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.clipsToBounds = false

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.frame = cell.contentView.frame.inset(
            by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        )
    }

    private func iconName(for exerciseName: String) -> String {
        let name = exerciseName.lowercased()

        if name.contains("bench") || name.contains("chest") || name.contains("fly") || name.contains("push-up") || name.contains("pushup") {
            return "figure.strengthtraining.traditional"
        }

        if name.contains("row") || name.contains("pull") || name.contains("lat") || name.contains("trap") || name.contains("deadlift") {
            return "figure.rower"
        }

        if name.contains("squat") || name.contains("leg") || name.contains("lunge") || name.contains("calf") || name.contains("hamstring") || name.contains("quad") || name.contains("glute") {
            return "figure.run"
        }

        if name.contains("curl") || name.contains("tricep") || name.contains("bicep") || name.contains("forearm") || name.contains("dumbbell") {
            return "dumbbell"
        }

        if name.contains("plank") || name.contains("crunch") || name.contains("core") || name.contains("ab") || name.contains("oblique") {
            return "figure.core.training"
        }

        if name.contains("upper body") || name.contains("upperbody") {
            return "figure.strengthtraining.functional"
        }

        if name.contains("full body") || name.contains("fullbody") || name.contains("total body") {
            return "figure.mixed.cardio"
        }

        return "bolt.heart.fill"
    }
}
