//
//  SetCell.swift
//  strata
//

import UIKit

class SetCell: UICollectionViewCell {

    @IBOutlet weak var setTitleLabel: UILabel!
    @IBOutlet weak var poundsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!

    func configure(setNumber: Int, weight: Int, reps: Int) {
        setTitleLabel.text = "Set \(setNumber)"
        poundsLabel.text = "\(weight) lbs"
        repsLabel.text = "\(reps) reps"
    }
}
