//
//  WorkoutRowCell.swift
//  strata
//

import UIKit

struct WorkoutSet {
    var weight: Int
    var reps: Int
}

class WorkoutRowCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var workoutNameLabel: UILabel!
    @IBOutlet weak var muscleGroupLabel: UILabel!
    @IBOutlet weak var setsCollectionView: UICollectionView!

    var sets: [WorkoutSet] = [
        WorkoutSet(weight: 15, reps: 12)
    ]

    override func awakeFromNib() {
        super.awakeFromNib()

        setsCollectionView.dataSource = self
        setsCollectionView.delegate = self

        if let layout = setsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }

    func configure(workoutName: String, muscleGroup: String) {
        workoutNameLabel.text = workoutName
        muscleGroupLabel.text = muscleGroup
        setsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sets.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item < sets.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SetCell", for: indexPath) as! SetCell
            let set = sets[indexPath.item]
            cell.configure(setNumber: indexPath.item + 1, weight: set.weight, reps: set.reps)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddSetCell", for: indexPath) as! AddSetCell
            cell.configure()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == sets.count {
            sets.append(WorkoutSet(weight: 0, reps: 0))
            setsCollectionView.reloadData()

            let newIndexPath = IndexPath(item: sets.count, section: 0)
            setsCollectionView.scrollToItem(at: newIndexPath, at: .right, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 70)
    }
}
