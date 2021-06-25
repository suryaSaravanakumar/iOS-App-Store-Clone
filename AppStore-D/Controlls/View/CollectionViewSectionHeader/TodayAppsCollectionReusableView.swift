//
//  TodayAppsCollectionReusableView.swift
//  AppStore-D
//
//  Created by Surya on 25/06/21.
//

import UIKit

class TodayAppsCollectionReusableView: UICollectionReusableView {
    //MARK: - Property Declaration
    static let reuseIdentifier = "TodayAppsCollectionReusableView"
    
    let sectionTitle = UILabel()
    let dateTitle = UILabel()
    let profileButton = UIImageView()
    
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
        sectionTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 26, weight: .bold))
        dateTitle.textColor = .secondaryLabel
        dateTitle.text = getCurrentDate().uppercased()
        
        profileButton.image = UIImage(systemName: "person.circle")
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        let stackView = UIStackView(arrangedSubviews: [dateTitle, sectionTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        addSubview(profileButton)
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            profileButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM"
        return dateFormatter.string(from: Date())
        
    }
    
}
