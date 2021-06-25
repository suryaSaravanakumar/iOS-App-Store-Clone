//
//  TodayAppsViewController.swift
//  AppStore-D
//
//  Created by Surya on 25/06/21.
//

import UIKit

class TodayAppsViewController: UIViewController {
    
    // MARK: - Property Declaration
    var collectionView: UICollectionView!
    lazy var sections:[Section] = { [unowned self] in
        return Bundle.main.decode([Section].self, from: "TodaysApp.json")
    }()
    var dataSource: UICollectionViewDiffableDataSource<Section,App>?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
        configureCollectionViewDiffableDatasource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadCollectionViewSnapshot()
    }
    
    
    //MARK: - Custom Method
    private func initalSetup(){
        collectionViewSetup()
    }
    
    private func collectionViewSetup(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        //Register Cells
        collectionView.register(TodayAppsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TodayAppsCollectionReusableView.reuseIdentifier)
        collectionView.register(TodaySpotlightCollectionViewCell.self, forCellWithReuseIdentifier: TodaySpotlightCollectionViewCell.reuseIdentifier)
        
    }
    
    private func reloadCollectionViewSnapshot(){
        var snapShot = NSDiffableDataSourceSnapshot<Section,App>()
        let appSections = self.sections
        snapShot.appendSections(appSections)
        
        for section in appSections{
            snapShot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapShot)
    }
    
    private func configureCollectionViewDiffableDatasource(){
        dataSource = UICollectionViewDiffableDataSource<Section,App>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, app) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaySpotlightCollectionViewCell.reuseIdentifier, for: indexPath) as? TodaySpotlightCollectionViewCell
            cell?.configure(with: app)
            return cell
        })
        
        collectionViewSectionHeaderSetup()
    }
    
    /**
        Preparing CollectionView Header
     */
    private func collectionViewSectionHeaderSetup(){
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            //Here we need to provide a view for a section header
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayAppsCollectionReusableView.reuseIdentifier, for: indexPath) as? TodayAppsCollectionReusableView else {
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
            return sectionHeader
        }
    }
}

//MARK: - UICollectionView Layoutsetup
extension TodayAppsViewController{
    private func makeTodaySpotLightSection() -> NSCollectionLayoutSection{
        
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 35)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/4))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        //Suplement View
        layoutSection.boundarySupplementaryItems = [CompositionalLayoutHelper.createCollectionViewSectionHeaderLayout()]
        
        return layoutSection
        
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        
        let compositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, layoutIndex in
            return self.makeTodaySpotLightSection()
        }
        return compositionalLayout
    }
    
}
