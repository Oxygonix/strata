//
//  ExercisePickerViewController.swift
//  strata
//
//  Created by Torres, Ian on 4/14/26.
//

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
        view.backgroundColor = .systemBackground

        filteredExercises = allExercises

        setUpTextField()
        setUpTableView()
        setUpCancelButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let safe = view.safeAreaInsets
        let padding: CGFloat = 20

        cancelButton.frame = CGRect(x: padding,
                                    y: safe.top + 8,
                                    width: 80,
                                    height: 36)

        textField.frame = CGRect(x: padding,
                                 y: cancelButton.frame.maxY + 12,
                                 width: view.bounds.width - (padding * 2),
                                 height: 44)

        tableView.frame = CGRect(x: 0,
                                 y: textField.frame.maxY + 12,
                                 width: view.bounds.width,
                                 height: view.bounds.height - textField.frame.maxY - 12)
    }

    private func setUpTextField() {
        textField.placeholder = "Search exercises"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        view.addSubview(textField)
    }

    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        view.addSubview(tableView)
    }

    private func setUpCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
    }

    @objc private func textDidChange() {
        let query = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""

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
        return true
    }

    private func selectExercise(_ exercise: ExerciseData) {
        onExerciseSelected?(exercise)
        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredExercises.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = filteredExercises[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = exercise.name
        content.secondaryText = exercise.muscles
            .sorted { $0.value > $1.value }
            .map(\.key)
            .prefix(3)
            .joined(separator: ", ")

        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectExercise(filteredExercises[indexPath.row])
    }
}
