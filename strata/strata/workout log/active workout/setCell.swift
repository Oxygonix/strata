import UIKit

class SetCell: UICollectionViewCell {

    @IBOutlet weak var setTitleLabel: UILabel!
    @IBOutlet weak var poundsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var deleteSetBtn: UIButton!

    var onValueChanged: ((_ weight: Int, _ reps: Int) -> Void)?
    var onDeleteTapped: (() -> Void)?

    private let weightTitleLabel = UILabel()
    private let repsTitleLabel = UILabel()
    private let weightField = UITextField()
    private let repsField = UITextField()

    override func awakeFromNib() {
        super.awakeFromNib()

        poundsLabel.isHidden = true
        repsLabel.isHidden = true
        deleteSetBtn.isHidden = true

        setTitleLabel.textAlignment = .center

        configureTitleLabel(weightTitleLabel, text: "lbs")
        configureTitleLabel(repsTitleLabel, text: "reps")

        configureField(weightField, placeholder: "0")
        configureField(repsField, placeholder: "0")

        contentView.addSubview(weightTitleLabel)
        contentView.addSubview(weightField)
        contentView.addSubview(repsTitleLabel)
        contentView.addSubview(repsField)

        weightField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        repsField.addTarget(self, action: #selector(fieldChanged), for: .editingChanged)
        
        deleteSetBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)

        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        deleteSetBtn.isHidden = true
        onDeleteTapped = nil
        onValueChanged = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let width = contentView.bounds.width
        setTitleLabel.frame = CGRect(x: 6, y: 4, width: width - 12, height: 14)

        weightTitleLabel.frame = CGRect(x: 8, y: 22, width: width - 16, height: 10)
        weightField.frame = CGRect(x: 8, y: 32, width: width - 16, height: 14)

        repsTitleLabel.frame = CGRect(x: 8, y: 48, width: width - 16, height: 10)
        repsField.frame = CGRect(x: 8, y: 58, width: width - 16, height: 12)
    }

    private func configureTitleLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .systemFont(ofSize: 9, weight: .semibold)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
    }

    private func configureField(_ field: UITextField, placeholder: String) {
        field.borderStyle = .none
        field.backgroundColor = .clear
        field.font = .systemFont(ofSize: 14, weight: .semibold)
        field.textColor = .label
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.placeholder = placeholder
    }

    func configure(setNumber: Int, weight: Int, reps: Int, showDeleteButton: Bool) {
        setTitleLabel.text = "Set \(setNumber)"
        weightField.text = weight == 0 ? "" : "\(weight)"
        repsField.text = reps == 0 ? "" : "\(reps)"
        deleteSetBtn.isHidden = !showDeleteButton
    }

    @objc private func fieldChanged() {
        let weight = Int(weightField.text ?? "") ?? 0
        let reps = Int(repsField.text ?? "") ?? 0
        onValueChanged?(weight, reps)
    }

    @objc private func deleteTapped() {
        onDeleteTapped?()
    }
}
