//
//  FeaturedCollectionViewCell.swift
//  AppStore-D
//
//  Created by Surya on 13/06/21.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell,SelfConfiguringCell {
    //MARK: - Property Declarations
    static var reuseIdentifier = "FeaturedCollectionViewCell"
    let tagline = UILabel()
    let appTitle = UILabel()
    let appSubtitle = UILabel()
    let appPreviewImageView = UIImageView()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeFeaturedCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Custom methods
    private func makeFeaturedCellUI(){
        tagline.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .bold))
        tagline.textColor = .systemBlue
        
        appTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        appTitle.textColor = .label
        
        appSubtitle.font = UIFont.preferredFont(forTextStyle: .title3)
        appSubtitle.textColor = .secondaryLabel
        
        appPreviewImageView.layer.cornerRadius = 10
        appPreviewImageView.clipsToBounds = true
        appPreviewImageView.contentMode = .scaleAspectFill
        
        //Add all the above items in stackview
        let stackView = UIStackView(arrangedSubviews: [tagline,appTitle,appSubtitle,appPreviewImageView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(10, after: appSubtitle)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    func configure(with app: App) {
        tagline.text = app.tagline
        appTitle.text = app.name
        appSubtitle.text = app.subheading
        appPreviewImageView.image = UIImage(named: app.image)
    }
    
}
