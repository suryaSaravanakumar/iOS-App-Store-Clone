//
//  GamesViewController.swift
//  AppStore-D
//
//  Created by Surya on 23/06/21.
//



import UIKit

class BaseAppsViewController: UIViewController {
    
    //MARK: - Outlet Declaration
    var collectionView: UICollectionView!
    
    //MARK: - Property Declaration
    var sections:[Section]?
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: self.createCompositionalLayout()!)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        //Register Cells
        collectionView.register(CollectionViewSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier)
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.reuseIdentifier)
        collectionView.register(GridLayoutCollectionViewCell.self, forCellWithReuseIdentifier: GridLayoutCollectionViewCell.reuseIdentifier)
        collectionView.register(SmallGridLayoutCollectionViewCell.self, forCellWithReuseIdentifier: SmallGridLayoutCollectionViewCell.reuseIdentifier)
        collectionView.register(SmallFeaturedCollectionViewCell.self, forCellWithReuseIdentifier: SmallFeaturedCollectionViewCell.reuseIdentifier)
        
        
    }
    
    /**
     Preparing CollectionView Header
     */
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
            sectionHeader.sectionSubTitle.text = sectionData.subtitle
            return sectionHeader
        }
    }
    
    //MARK: Diffable datasource configurations
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,App>(collectionView: self.collectionView, cellProvider: { (collectionView, indexpath, app) -> UICollectionViewCell? in
            
            guard  let appSections = self.sections else {return UICollectionViewCell()}
            switch appSections[indexpath.section].type{
            case SectionType.mediumTable.rawValue:
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: GridLayoutCollectionViewCell.reuseIdentifier,
                                                               for: indexpath) as? GridLayoutCollectionViewCell
                
                cell?.configure(with: app)
                return cell
            case SectionType.listTable.rawValue:
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SmallGridLayoutCollectionViewCell.reuseIdentifier,
                                                               for: indexpath) as? SmallGridLayoutCollectionViewCell
                
                cell?.configure(with: app)
                return cell
            case SectionType.smallFeatured.rawValue:
                let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SmallFeaturedCollectionViewCell.reuseIdentifier,
                                                               for: indexpath) as? SmallFeaturedCollectionViewCell
                
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
        guard  let appSections = self.sections else {return}
        snapShot.appendSections(appSections)
        
        for section in appSections{
            snapShot.appendItems(section.items, toSection: section)
        }
        
        dataSource?.apply(snapShot)
    }
    
}

//MARK: - UICollectionViewCompositionalLayout Handler
extension BaseAppsViewController{
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout?{
        let compositionalLayout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            guard  let appSections = self.sections else {return nil }
            switch appSections[sectionIndex].type{
            case SectionType.mediumTable.rawValue:
                return CompositionalLayoutHelper.createGridLayoutCollectionSection()
            case SectionType.listTable.rawValue:
                return CompositionalLayoutHelper.createListLayoutSection()
            case SectionType.smallFeatured.rawValue:
                return CompositionalLayoutHelper.createSmallFeaturedLayoutCollectionSection()
            default:
                return CompositionalLayoutHelper.createFeaturedCollectionSection()
            }
        }
        return compositionalLayout
    }
    
}
