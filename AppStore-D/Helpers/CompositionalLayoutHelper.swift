//
//  CompositionalLayoutHelper.swift
//  AppStore-D
//
//  Created by Surya on 18/06/21.
//

import UIKit

struct CompositionalLayoutHelper {
    
    /// This Function helps to build the section looks and behaviour while in UICompositional layout
    static func createFeaturedCollectionSection() -> NSCollectionLayoutSection{
        ///Collection Compositional layour consist of the following items
        ///NSColletctionLayoutSize, NSColletctionLayoutItem, NSColletctionLayoutGroup, NSColletctionLayoutSection
        /// 1. Item SIze - Size of the cell which needs to be shown in the collection view
        /// 2. Item - Cell  which needs to be shown in the collection view
        /// 3.Group -  Group of items is called a group
        /// 4. Section -  Group of groups is called a Section
        
        //Step 1: - Create layout Item Size
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        //Step 2: - Create an item by passing the created layout item size
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
        //Step 3: - Create a group size
        let layoutGroupize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .estimated(300))
        //Step 4: - Create a group by passing the created group size and  item
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupize, subitems: [layoutItem])
        //Step 5: - Create a section but passing the created group
        let layoutSection  = NSCollectionLayoutSection(group: layoutGroup)
        ///Add  orthogonalScrollingBehavior to make the current focused cell to needed behaviour, here we are making it to stay in center while scrolling
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
    
    static func createGridLayoutCollectionSection () -> NSCollectionLayoutSection{
        
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        //Adding a section header to  this section of your collection view
        layoutSection.boundarySupplementaryItems = [createCollectionViewSectionHeaderLayout()]
        
        return layoutSection
    }
    
    static func createListLayoutSection() -> NSCollectionLayoutSection{
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        let layoutGroupSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        let layputGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layputGroup)
        
        //Adding a section header to  this section of your collection view
        layoutSection.boundarySupplementaryItems = [createCollectionViewSectionHeaderLayout()]
        return layoutSection
    }
    
    static func createSmallFeaturedLayoutCollectionSection () -> NSCollectionLayoutSection{
        
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.65))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .estimated(280))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.contentInsets  = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        //Adding a section header to  this section of your collection view
        layoutSection.boundarySupplementaryItems = [createCollectionViewSectionHeaderLayout()]
        
        return layoutSection
    }
    
    //MARK: Header compositional layout
    static func createCollectionViewSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem{
        let sectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let sectionSupplementaryView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        //        sectionSupplementaryView.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        return sectionSupplementaryView
    }
}
