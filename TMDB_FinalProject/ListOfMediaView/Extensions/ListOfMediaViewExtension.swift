//
//  ListOfMediaViewExtension.swift
//  TMDB
//
//  Created by Kirill Romanenko on 02.01.2023.
//

import UIKit

// MARK:- Protocol for presenting DetailViewController from CollectionView

protocol PresenterOfDetailView {
    func presentDetailView(_ name: String)
}

extension ListOfMediaViewController: PresenterOfDetailView{

    func presentDetailView(_ name: String) {
        let controller = DetailViewController()
        controller.viewModel?.name = name
        controller.viewModel?.typeOfContent = viewModel?.typeOfContent ?? ""
        let presentController = UINavigationController(rootViewController: controller)
        presentController.modalPresentationStyle = .fullScreen
        self.present(presentController, animated: true, completion: nil)
    }
}

// MARK:- Adding UISearchBarDelegate extension to ListOfMediaViewController

extension ListOfMediaViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.filteredMedia.removeAll()
        collectionView.arrayOfFilteredMedia.removeAll()
        collectionView.isFiltering = false
        segmentControl.setVisible(true, 50)
        collectionView.reloadData()
    }
}

// MARK:- Adding UISearchResultsUpdating extension to ListOfMediaViewController

extension ListOfMediaViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if isFiltering {
            guard let text = searchController.searchBar.text else { return }
            segmentControl.setVisible(false, 0)
            collectionView.isFiltering = true
            filterContentForSearchText(text)
        }
    }
    
    private func filterContentForSearchText(_ searchText: String){
        viewModel?.filteredMedia = viewModel?.arrayOfMedia.filter({ (mediaModel: MediaModel) -> Bool in
            mediaModel.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        collectionView.arrayOfFilteredMedia = viewModel?.filteredMedia ?? []
        collectionView.reloadData()
    }
}
