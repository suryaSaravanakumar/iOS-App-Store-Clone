//
//  GridLayoutCollectionViewCell.swift
//  AppStore-D
//
//  Created by Surya on 13/06/21.
//

import UIKit

class GridLayoutCollectionViewCell: UICollectionViewCell,SelfConfiguringCell {
    
    //MARK: - Property Declarations
    static var reuseIdentifier: String = "GridLayoutCollectionViewCell"
    let appTitle = UILabel()
    let appSubtitle = UILabel()
    let appIconImageView = UIImageView()
    let appDownloadButon = UIButton()
    let appInAppPurchaseLabel = UILabel()
    
    
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
        appTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        appTitle.textColor = .label
        
        appSubtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appSubtitle.numberOfLines = 2
        appSubtitle.textColor = .secondaryLabel
        
        appIconImageView.layer.cornerRadius = 15
        appIconImageView.clipsToBounds = true
        appIconImageView.contentMode = .scaleAspectFill
        
        appInAppPurchaseLabel.font = UIFont.systemFont(ofSize: 9)
        appInAppPurchaseLabel.textColor = .secondaryLabel
        
        appDownloadButon.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        appIconImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let titleHolderStackView = UIStackView(arrangedSubviews: [appTitle,appSubtitle])
        titleHolderStackView.axis = .vertical

        let downloadBtnHolderStackView = UIStackView(arrangedSubviews: [appDownloadButon])
        downloadBtnHolderStackView.axis = .vertical
   
    
        let stackView = UIStackView(arrangedSubviews: [appIconImageView,titleHolderStackView,appDownloadButon])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 10
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            appIconImageView.heightAnchor.constraint(equalToConstant: 50),
            appIconImageView.widthAnchor.constraint(equalToConstant: 50),
            appSubtitle.widthAnchor.constraint(equalToConstant: contentView.frame.width / 1.5),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    func configure(with app: App) {
        appTitle.text = app.name
        appSubtitle.text = app.subheading
        appIconImageView.image = UIImage(named: app.image)
        appInAppPurchaseLabel.text = "In App Purchase"
        appInAppPurchaseLabel.isHidden = app.iap ? false : true
    }
    
}
