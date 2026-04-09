import UIKit

struct WorkoutSet {
    var weight: Int
    var reps: Int
}

class WorkoutRowCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var muscleGroupLabel: UILabel!
    @IBOutlet weak var setsCollectionView: UICollectionView!
    @IBOutlet weak var rowCardView: UIView!

    private var sets: [WorkoutSet] = []
    private let selectedGradientLayer = CAGradientLayer()

    var onAddSet: (() -> Void)?
    var onSetChanged: ((_ setIndex: Int, _ weight: Int, _ reps: Int) -> Void)?

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

        // This gradient stuff doesn't work too well but ill leave for now if we can figure it out later
        selectedGradientLayer.colors = [
            UIColor(red: 0.98, green: 0.92, blue: 0.93, alpha: 1.0).cgColor,
            UIColor(red: 0.95, green: 0.86, blue: 0.88, alpha: 1.0).cgColor
        ]
        selectedGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        selectedGradientLayer.endPoint = CGPoint(x: 1, y: 1)

        applyDeselectedStyle()
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

    func configure(workoutName: String, muscleGroup: String, sets: [WorkoutSet]) {
        workoutNameLabel.text = workoutName
        muscleGroupLabel.text = muscleGroup
        self.sets = sets
        setsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sets.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < sets.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetCell", for: indexPath) as! SetCell
            let set = sets[indexPath.item]

            cell.configure(setNumber: indexPath.item + 1, weight: set.weight, reps: set.reps)
            cell.onValueChanged = { [weak self] weight, reps in
                self?.onSetChanged?(indexPath.item, weight, reps)
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
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 85, height: 72)
    }
}
