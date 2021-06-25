//
//  TodaySpotlightCollectionViewCell.swift
//  AppStore-D
//
//  Created by Surya on 22/06/21.
//

import UIKit

class TodaySpotlightCollectionViewCell: UICollectionViewCell,SelfConfiguringCell {
    
    //MARK: Property Declaration
    static var reuseIdentifier: String = "TodaySpotlightCollectionViewCell"
    let appHolderView = UIView()
    var spotLightImageView = UIImageView()
    let appTitle = UILabel()
    let appCategory = UILabel()
    let appTagLine = UILabel()
    let bottomTagHolderView = UIView()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Custom Methods
    func configure(with app: App) {
        appCategory.text = app.tagline
        appTitle.text = app.name
        appTagLine.text = app.subheading
        spotLightImageView.image = UIImage(named: app.image)
        spotLightImageView.contentMode = .scaleAspectFill
        makeUI(for: CellType.init(rawValue: app.cellType ?? CellType.fullImage.rawValue) ?? CellType.fullImage)
    }
    
    
    private func makeUI(for cellType: CellType){
        
        appHolderView.layer.cornerRadius = 20
        appHolderView.clipsToBounds = true
        appHolderView.translatesAutoresizingMaskIntoConstraints = false
        
        spotLightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        appTagLine.translatesAutoresizingMaskIntoConstraints = false
        
        appCategory.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appCategory.textColor = .systemGray
        
        appTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        appTagLine.font = UIFont.preferredFont(forTextStyle: .callout)
        
        bottomTagHolderView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        bottomTagHolderView.translatesAutoresizingMaskIntoConstraints = false
        bottomTagHolderView.clipsToBounds = true
        bottomTagHolderView.backgroundColor = .clear
        
        let titleStackView = UIStackView(arrangedSubviews: [appCategory,appTitle])
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.axis = .vertical
        titleStackView.spacing = 5
        
       
        appHolderView.addSubview(spotLightImageView)
        contentView.addSubview(appHolderView)
        
        switch cellType {
        case .fullImage:
        
            
            appHolderView.addSubview(titleStackView)
            appHolderView.addSubview(appTagLine)
            
            NSLayoutConstraint.activate([
                appHolderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                appHolderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                appHolderView.topAnchor.constraint(equalTo: contentView.topAnchor),
                appHolderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                titleStackView.topAnchor.constraint(equalTo: appHolderView.topAnchor, constant: 10),
                titleStackView.leadingAnchor.constraint(equalTo: appHolderView.leadingAnchor, constant: 10),
                appTagLine.leadingAnchor.constraint(equalTo: appHolderView.leadingAnchor, constant: 10),
                appTagLine.bottomAnchor.constraint(equalTo: appHolderView.bottomAnchor, constant: -15),
                
                spotLightImageView.leadingAnchor.constraint(equalTo: appHolderView.leadingAnchor),
                spotLightImageView.trailingAnchor.constraint(equalTo: appHolderView.trailingAnchor),
                spotLightImageView.topAnchor.constraint(equalTo: appHolderView.topAnchor),
                spotLightImageView.bottomAnchor.constraint(equalTo: appHolderView.bottomAnchor),
                
            ])
        case .halfImage:
            bottomTagHolderView.addSubview(appTagLine)
            bottomTagHolderView.backgroundColor = UIColor(named: "lightBlack")
            bottomTagHolderView.addSubview(titleStackView)
            appHolderView.addSubview(bottomTagHolderView)
            
            NSLayoutConstraint.activate([
                appHolderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                appHolderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                appHolderView.topAnchor.constraint(equalTo: contentView.topAnchor),
                appHolderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                spotLightImageView.leadingAnchor.constraint(equalTo: appHolderView.leadingAnchor),
                spotLightImageView.trailingAnchor.constraint(equalTo: appHolderView.trailingAnchor),
                spotLightImageView.topAnchor.constraint(equalTo: appHolderView.topAnchor),
                spotLightImageView.bottomAnchor.constraint(equalTo: appHolderView.bottomAnchor),
                bottomTagHolderView.heightAnchor.constraint(equalToConstant: 120),
                bottomTagHolderView.leadingAnchor.constraint(equalTo: appHolderView.leadingAnchor),
                bottomTagHolderView.bottomAnchor.constraint(equalTo: appHolderView.bottomAnchor),
                bottomTagHolderView.trailingAnchor.constraint(equalTo: appHolderView.trailingAnchor),
                titleStackView.topAnchor.constraint(equalTo: bottomTagHolderView.topAnchor, constant: 10),
                titleStackView.leadingAnchor.constraint(equalTo: bottomTagHolderView.leadingAnchor, constant: 10),
               
                appTagLine.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
                appTagLine.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 5),
                
                
                
            ])
        }
    
        
    }
    
    
}
