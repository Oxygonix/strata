import UIKit

class WorkoutRowCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var muscleGroupLabel: UILabel!
    @IBOutlet weak var setsCollectionView: UICollectionView!
    @IBOutlet weak var rowCardView: UIView!
    @IBOutlet weak var IntensityLevel: UISlider!

    private var sets: [WorkoutSet] = []
    private let selectedGradientLayer = CAGradientLayer()
    private var selectedSetIndex: Int?

    var onAddSet: (() -> Void)?
    var onSetChanged: ((_ setIndex: Int, _ weight: Int, _ reps: Int) -> Void)?
    var onDeleteSet: ((_ setIndex: Int) -> Void)?
    var onIntensityChanged: ((_ intensity: Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        setsCollectionView.dataSource = self
        setsCollectionView.delegate = self

        if let layout = setsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }

        selectedGradientLayer.colors = [
            UIColor(red: 0.97, green: 0.42, blue: 0.44, alpha: 1.0).cgColor,
            UIColor(red: 0.84, green: 0.24, blue: 0.29, alpha: 1.0).cgColor
        ]

        selectedGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        selectedGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        selectedGradientLayer.locations = [0.0, 1.0]

        setUpIntensitySlider()
        applyDeselectedStyle()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        selectedSetIndex = nil
        onAddSet = nil
        onSetChanged = nil
        onDeleteSet = nil
        onIntensityChanged = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        selectedGradientLayer.frame = rowCardView.bounds
        selectedGradientLayer.cornerRadius = rowCardView.layer.cornerRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? applySelectedStyle() : applyDeselectedStyle()
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if !isSelected {
            highlighted ? applySelectedStyle() : applyDeselectedStyle()
        }
    }

    private func applySelectedStyle() {
        if selectedGradientLayer.superlayer == nil {
            rowCardView.layer.insertSublayer(selectedGradientLayer, at: 0)
        }
        rowCardView.backgroundColor = .clear
    }

    private func applyDeselectedStyle() {
        selectedGradientLayer.removeFromSuperlayer()
        rowCardView.backgroundColor = UIColor.white.withAlphaComponent(0.72)
    }

    private func setUpIntensitySlider() {
        let transparentThumb = UIGraphicsImageRenderer(size: CGSize(width: 24, height: 24)).image { _ in
            UIColor.clear.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 24, height: 24)).fill()
        }

        IntensityLevel.setThumbImage(transparentThumb, for: .normal)
        IntensityLevel.setThumbImage(transparentThumb, for: .highlighted)
        
        IntensityLevel.isContinuous = true
        IntensityLevel.addTarget(self, action: #selector(intensitySliderChanged(_:)), for: .valueChanged)
    }

    @objc private func intensitySliderChanged(_ sender: UISlider) {
        sender.value = max(1, min(5, round(sender.value)))
        onIntensityChanged?(Int(sender.value))
    }

    func configure(workoutName: String, muscleGroup: String, sets: [WorkoutSet], intensity: Int) {
        workoutNameLabel.text = workoutName
        muscleGroupLabel.text = muscleGroup
        self.sets = sets
        IntensityLevel.minimumValue = 1
        IntensityLevel.maximumValue = 5
        IntensityLevel.value = Float(intensity)

        if let selectedSetIndex, selectedSetIndex >= sets.count {
            self.selectedSetIndex = nil
        }

        setsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sets.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < sets.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetCell", for: indexPath) as! SetCell
            let set = sets[indexPath.item]
            let isSelectedSet = selectedSetIndex == indexPath.item

            cell.configure(
                setNumber: indexPath.item + 1,
                weight: set.weight,
                reps: set.reps,
                showDeleteButton: isSelectedSet
            )

            cell.onValueChanged = { [weak self] weight, reps in
                self?.onSetChanged?(indexPath.item, weight, reps)
            }

            cell.onDeleteTapped = { [weak self] in
                self?.selectedSetIndex = nil
                self?.onDeleteSet?(indexPath.item)
            }

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSetCell", for: indexPath) as! AddSetCell
            cell.configure()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == sets.count {
            onAddSet?()
        } else {
            if selectedSetIndex == indexPath.item {
                selectedSetIndex = nil
            } else {
                selectedSetIndex = indexPath.item
            }
            collectionView.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 85, height: 72)
    }
    
}
