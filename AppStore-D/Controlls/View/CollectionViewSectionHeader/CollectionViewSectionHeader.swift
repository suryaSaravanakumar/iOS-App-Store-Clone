//
//  CollectionViewSectionHeader.swift
//  AppStore-D
//
//  Created by Surya on 14/06/21.
//

import UIKit

class CollectionViewSectionHeader: UICollectionReusableView {
    //MARK: - Property Declaration
    static let reuseIdentifier = "CollectionViewSectionHeader"
    
    let sectionTitle = UILabel()
    let sectionSubTitle = UILabel()
    
    //MARK:- Intis
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Custom Methods
    private func makeUI(){
        sectionTitle.textColor = .label
        sectionTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 22, weight: .bold))
        sectionSubTitle.textColor = .secondaryLabel
        
        let separatorView = UIView(frame: .zero)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .quaternaryLabel
       
        
        let stackView = UIStackView(arrangedSubviews: [separatorView,sectionTitle,sectionSubTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        stackView.setCustomSpacing(10, after: separatorView)
    }
    
        
}
