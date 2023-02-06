//
//  ListOfMediaViewController.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import UIKit

class ListOfMediaViewController: UIViewController {
    
    var viewModel: ListOfMediaViewModel? = ListOfMediaViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    let segmentControl = UISegmentedControl(items: [Constants.singelton.movieType,
                                                    Constants.singelton.seriesType])
    let refreshControl = UIRefreshControl()
    let collectionView = MyCollectionView()
    
    deinit {
        print("\(ListOfMediaViewController.self) deinited!")
    }
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else{ return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool{
        viewModel?.isFiltered = searchController.isActive && !searchBarIsEmpty
        guard let isFiltered = viewModel?.isFiltered else {return false}
        return isFiltered
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setArrayOfMedia()
        setupConfigOfView()
        setupSearchController()
        setupSegmentControll()
        setupCollectionView()
    }
    
    // MARK:- Setup configuration of ListOfMediaView
    
    private func setupConfigOfView(){
        self.view.backgroundColor = .white
        title = "Films" // PUT IN CONSTATNTS!!!
    }
    
    // MARK:- Setup SearchController to ListOfMediaView
    
    func setupSearchController(){
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.definesPresentationContext = true
        navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    // MARK:- Setup SegmentControl to ListOfMediaView
    
    func setupSegmentControll(){
        segmentControl.selectedSegmentIndex = 0
        segmentControl.autoresizingMask = [.flexibleWidth]
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.addTarget(self,
                                 action: #selector(selectedValueOfSegment),
                                 for: .valueChanged)
        self.view.addSubview(segmentControl)
        
        segmentControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
    }
    
    @objc private func selectedValueOfSegment(target: UISegmentedControl){
        switch target.selectedSegmentIndex {
        case 1:
            viewModel?.setTypeOfContent(typeOfContent: Constants.singelton.seriesType.lowercased())
        default:
            viewModel?.setTypeOfContent(typeOfContent: Constants.singelton.movieType.lowercased())
        }
        viewModel?.setArrayOfMedia()
        collectionView.arrayOfMedia = viewModel?.arrayOfMedia ?? []
        collectionView.reloadData()

    }
    
    // MARK:- Setup CollectionView to ListOfMediaView
    
    func setupCollectionView(){
        refreshControl.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.myDelegate = self
        collectionView.arrayOfMedia = viewModel?.arrayOfMedia ?? []
        collectionView.addSubview(refreshControl)
        self.view.addSubview(collectionView)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    @objc func refresh(_ sender: AnyObject){
        self.refreshControl.beginRefreshing()
        viewModel?.refreshMedia{ [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
}
