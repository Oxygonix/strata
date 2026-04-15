//
//  WorkoutDetailViewController.swift
//  strata
//
//  Created by Sanjana Madhav on 4/3/26.
//

import UIKit

class WorkoutDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var workout: Workout?

    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var bodyPartsWorkedLabel: UILabel!
    @IBOutlet weak var difficultyLevelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private let bottomButtonContainer = UIView()
    private let addToWorkoutLogButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLabels()
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
    }

    private func setupLabels() {
        [bodyPartsWorkedLabel, difficultyLevelLabel, durationLabel].forEach { label in
            label?.textColor = .label
            label?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            label?.numberOfLines = 0
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 96
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 110, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 110, right: 0)
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
        if let bodyParts = workout?.bodyPartsWorked {
            setBoldTitle(
                for: bodyPartsWorkedLabel,
                title: "Body Parts Worked",
                value: bodyParts.joined(separator: ", ")
            )
        }

        setBoldTitle(
            for: difficultyLevelLabel,
            title: "Difficulty Level",
            value: workout?.difficulty ?? ""
        )

        if let duration = workout?.duration {
            setBoldTitle(
                for: durationLabel,
                title: "Duration",
                value: "\(duration) mins"
            )
        }

        tableView.reloadData()
    }

    func setBoldTitle(for label: UILabel, title: String, value: String) {
        let fullText = "\(title): \(value)"
        let attributedText = NSMutableAttributedString(string: fullText)

        let titleRange = NSRange(location: 0, length: title.count)
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 17, weight: .bold),
            range: titleRange
        )

        let valueRange = NSRange(location: title.count, length: fullText.count - title.count)
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 17, weight: .regular),
            range: valueRange
        )

        attributedText.addAttribute(
            .foregroundColor,
            value: UIColor.label,
            range: titleRange
        )

        attributedText.addAttribute(
            .foregroundColor,
            value: UIColor.secondaryLabel,
            range: valueRange
        )

        label.attributedText = attributedText
    }

    @objc private func addToWorkoutLogTapped() {
        print("Add to Workout Log tapped for \(workout?.name ?? "Unknown Workout")")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout?.exercises.count ?? 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)

        guard let exercise = workout?.exercises[indexPath.row] else {
            return cell
        }

        var content = UIListContentConfiguration.subtitleCell()
        content.text = exercise.name
        content.secondaryText = "\(exercise.sets) sets • \(exercise.reps) reps • Rest: \(exercise.rest)"
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
