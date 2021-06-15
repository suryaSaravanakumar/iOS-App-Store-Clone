//
//  ViewController.swift
//  AppStore-D
//
//  Created by Surya on 13/06/21.
//

import UIKit

class AppsViewController: UIViewController {
    
    //MARK: - Outlet Declaration
    var collectionView: UICollectionView!
    
    //MARK: - Property Declaration
    let sections = Bundle.main.decode([Section].self, from: "appstore.json")
    var dataSource: UICollectionViewDiffableDataSource<Section,App>?
    
    //MARK: - View LifCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadDataWithSnapShot()
    }
   
    
    //MARK: - Custom Methods
    private func initalSetup(){
        collectionViewSetup()
    }
    
    private func collectionViewSetup(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.reuseIdentifier)
        collectionView.register(GridLayoutCollectionViewCell.self, forCellWithReuseIdentifier: GridLayoutCollectionViewCell.reuseIdentifier)
        collectionView.register(SmallGridLayoutCollectionViewCell.self, forCellWithReuseIdentifier: SmallGridLayoutCollectionViewCell.reuseIdentifier)
        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier)
      
    }
    
    private func collectionViewSectionHeaderSetup(){
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            //Here we need to provide a view for a section header
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier, for: indexPath) as? CollectionViewSectionHeader else {
                return nil
            }
            
            //Getting the section data  by taking that from snapshot
            //S1 - Getting the items which is available in the datasource for the passed indexpath
            guard let item = self?.dataSource?.itemIdentifier(for: indexPath) else {return nil}
            //S2 - Finding the section data by passing the above item in the snapshot
            // For this app the containingItem is App(model which we created) Data
            guard let sectionData = self?.dataSource?.snapshot().sectionIdentifier(containingItem: item)  else {return nil}
            //S3 - Use the above found Section(Our model data) Data to get the needed data
            
            sectionHeader.sectionTitle.text = sectionData.title
            print(sectionData.title)
            sectionHeader.sectionSubTitle.text = sectionData.subtitle
    
            
            return sectionHeader
        }
    }
    
    //MARK: Diffable datasource configurations
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,App>(collectionView: self.collectionView, cellProvider: { (collectionView, indexpath, app) -> UICollectionViewCell? in
            
            switch self.sections[indexpath.section].type{
            case "mediumTable":
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: GridLayoutCollectionViewCell.reuseIdentifier,
                                                          for: indexpath) as? GridLayoutCollectionViewCell
                
                cell?.configure(with: app)
                return cell
            case "smallTable":
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SmallGridLayoutCollectionViewCell.reuseIdentifier,
                                                          for: indexpath) as? SmallGridLayoutCollectionViewCell

                cell?.configure(with: app)
                return cell
            default:
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.reuseIdentifier,
                                                          for: indexpath) as? FeaturedCollectionViewCell
                
                cell?.configure(with: app)
                return cell
            }
            
        })
        
        //Setup a header view for section
        collectionViewSectionHeaderSetup()
    }
    
    private func reloadDataWithSnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<Section,App>()
        snapShot.appendSections(sections)
        
        for section in sections{
            snapShot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapShot)
    }

}

//MARK: - UICollectionViewCompositionalLayout Handler
extension AppsViewController{
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        let compositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            switch self.sections[sectionIndex].type{
            case "mediumTable":
                return self.createGridLayoutCollectionSection()
            case "smallTable":
                return self.createSmallGridLayoutSection()
            default:
                return self.createFeaturedCollectionSection()
            }
        }
        return compositionalLayout
    }
    /// This Function helps to build the section looks and behaviour while in UICompositional layout
    private func createFeaturedCollectionSection() -> NSCollectionLayoutSection{
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
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        //Step 3: - Create a group size
        let layoutGroupize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(350))
        //Step 4: - Create a group by passing the created group size and  item
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupize, subitems: [layoutItem])
        //Step 5: - Create a section but passing the created group
        let layoutSection  = NSCollectionLayoutSection(group: layoutGroup)
        ///Add  orthogonalScrollingBehavior to make the current focused cell to needed behaviour, here we are making it to stay in center while scrolling
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
    
    private func createGridLayoutCollectionSection () -> NSCollectionLayoutSection{
        
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))

        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .fractionalWidth(0.55))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        //Adding a section header to  this section of your collection view
        layoutSection.boundarySupplementaryItems = [createCollectionViewSectionHeaderLayout()]
        
        return layoutSection
    }
    
    private func createSmallGridLayoutSection() -> NSCollectionLayoutSection{
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
    
    private func createCollectionViewSectionHeaderLayout() -> NSCollectionLayoutBoundarySupplementaryItem{
        let sectionSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .estimated(80))
        let sectionSupplementaryView = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//        sectionSupplementaryView.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        return sectionSupplementaryView
    }
    
    
    
    
}
