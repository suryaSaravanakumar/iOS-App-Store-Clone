//
//  ViewController.swift
//  AppStore-D
//
//  Created by Surya on 13/06/21.
//

import UIKit

class AppsViewController: BaseAppsViewController {
    
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        self.sections = Bundle.main.decode([Section].self, from: "apps.json")
        super.viewDidLoad()
    }
    
    
}

