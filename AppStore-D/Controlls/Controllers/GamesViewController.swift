//
//  GamesViewController.swift
//  AppStore-D
//
//  Created by Surya on 18/06/21.
//

import UIKit

class GamesViewController: BaseAppsViewController {
    // MARK: - View LifeCyle
    override func viewDidLoad() {
        self.sections = Bundle.main.decode([Section].self, from: "games.json")
        super.viewDidLoad()
    }
}
