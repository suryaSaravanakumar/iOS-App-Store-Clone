//
//  SearchAppViewController.swift
//  AppStore-D
//
//  Created by Surya on 22/06/21.
//

import UIKit

class SearchAppViewController: UIViewController {

   
    //MARK: - Outlet Declaration
    var collectionView: UICollectionView!
    
    //MARK: - Property Declaration
    lazy var sections:[Section] = { [unowned self] in
        Bundle.main.decode([Section].self, from: "searchSuggestions.json")
    }()
    var dataSource: UICollectionViewDiffableDataSource<Section,App>?
    let searchController = UISearchController()
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initalSetup()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadDataWithSnapShot()
    }
    
    //MARK: - CustomMethods
    private func initalSetup(){
        searchBarSetup()
        collectionViewSetup()
    }
    
    private func searchBarSetup(){
        searchController.searchBar.placeholder = "Games, Apps, Stories and More"
        navigationItem.searchController = searchController
    }
    
    private func collectionViewSetup(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createCompositionalLayout()!)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        //Register Cells
        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier)
        collectionView.register(GridLayoutCollectionViewCell.self, forCellWithReuseIdentifier: GridLayoutCollectionViewCell.reuseIdentifier)
    }
    
    /**
        Preparing CollectionView Header
     */
    private func collectionViewSectionHeaderSetup(){
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier, for: indexPath) as? CollectionViewSectionHeader else {
                return nil
            }
            guard let item = self?.dataSource?.itemIdentifier(for: indexPath) else {return nil}
            guard let sectionData = self?.dataSource?.snapshot().sectionIdentifier(containingItem: item)  else {return nil}
            sectionHeader.sectionTitle.text = sectionData.title
            return sectionHeader
        }
    
}
    
    //MARK: Diffable datasource configurations
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,App>(collectionView: self.collectionView, cellProvider: { (collectionView, indexpath, app) -> UICollectionViewCell? in
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: GridLayoutCollectionViewCell.reuseIdentifier,
                                                           for: indexpath) as? GridLayoutCollectionViewCell
            
            cell?.configure(with: app)
            return cell
            
        })
        
        //Setup a header view for section
        collectionViewSectionHeaderSetup()
    }
    
    private func reloadDataWithSnapShot(){
        var snapShot = NSDiffableDataSourceSnapshot<Section,App>()
        snapShot.appendSections(self.sections)
        
        for section in self.sections{
            snapShot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapShot)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout?{
        let compositionalLayout = UICollectionViewCompositionalLayout(section:  CompositionalLayoutHelper.createListLayoutCollectionSection())
        return compositionalLayout
    }


}
