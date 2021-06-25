//
//  AppStoreCellConfigurable.swift
//  AppStore-D
//
//  Created by Surya on 13/06/21.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with app: App)
}


struct AppStoreViewModel{
    
}
