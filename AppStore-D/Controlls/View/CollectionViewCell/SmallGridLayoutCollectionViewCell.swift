//
//  SmallGridLayoutCollectionViewCell.swift
//  AppStore-D
//
//  Created by Surya on 14/06/21.
//

import UIKit

class SmallGridLayoutCollectionViewCell: UICollectionViewCell,SelfConfiguringCell {
    //MARK: - Property Declarations
    static var reuseIdentifier: String = "SmallGridLayoutCollectionViewCell"
    let appTitle = UILabel()
    let appIconImageView = UIImageView()
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Custom methods
    private func makeCellUI(){
        appTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        appTitle.textColor = .label
        
        appIconImageView.layer.cornerRadius = 5
        appIconImageView.clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [appIconImageView,appTitle])
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            appIconImageView.widthAnchor.constraint(equalToConstant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with app: App) {
        appTitle.text = app.name
        appIconImageView.image = UIImage(named: app.image)
    }
    
}
