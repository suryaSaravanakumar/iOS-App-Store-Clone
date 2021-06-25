//
//  SmallFeaturedCollectionViewCell.swift
//  AppStore-D
//
//  Created by Surya on 17/06/21.
//

import UIKit

class SmallFeaturedCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    //MARK: - Property declaration
    static var reuseIdentifier: String = "SmallFeaturedCollectionViewCell"
    let appTitle = UILabel()
    let appSubTitle = UILabel()
    let appPreviewImageView = UIImageView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Methods
    
    private func makeUI(){
        appTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15, weight: .regular))
        appTitle.textColor = .label
        
        appSubTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .regular))
        appTitle.textColor = .secondaryLabel

        appPreviewImageView.layer.cornerRadius = 10
        appPreviewImageView.clipsToBounds = true
        appPreviewImageView.contentMode = .scaleAspectFill

        let stackView =  UIStackView(arrangedSubviews: [appPreviewImageView,appTitle,appSubTitle])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setCustomSpacing(10, after: appPreviewImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            appPreviewImageView.heightAnchor.constraint(equalToConstant: 150),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
      
    }
    
    func configure(with app: App) {
        appTitle.text = app.name
        appSubTitle.text = app.subheading
        appPreviewImageView.image = UIImage(named: app.image)
    }
    
    
    
}
