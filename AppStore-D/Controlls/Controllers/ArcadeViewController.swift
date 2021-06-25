//
//  ArcadeViewController.swift
//  AppStore-D
//
//  Created by Surya on 22/06/21.
//

import UIKit

class ArcadeViewController: BaseAppsViewController {

    // MARK: - Navigation
    override func viewDidLoad() {
        self.sections = Bundle.main.decode([Section].self, from: "games.json")
        super.viewDidLoad()
    }
    

}
