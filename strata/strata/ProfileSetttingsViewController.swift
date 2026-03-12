//
//  ProfileSetttingsViewController.swift
//  strata
//
//  Created by Munoz, Ethan I on 3/11/26.
//

import UIKit

class ProfileSetttingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func equipmentButton(_ sender: UIButton) {
        sender.isSelected.toggle()

            if sender.isSelected {
                sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else {
                sender.setImage(UIImage(systemName: "square"), for: .normal)
            }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
