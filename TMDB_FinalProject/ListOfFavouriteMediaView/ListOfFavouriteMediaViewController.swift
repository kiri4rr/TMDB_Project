//
//  ListOfFavouriteMediaViewController.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import UIKit

class ListOfFavouriteMediaViewController: UIViewController{
    
    var viewModel: ListOfFavouriteViewModel? = ListOfFavouriteViewModel()
    let tableView: UITableView = UITableView()
    
    deinit {
        print("\(ListOfFavouriteViewModel.self) deinited!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel?.setArrayOfFavouriteMedia()
        tableView.reloadData()
    }
    
    //MARK: - Setup TableView in View

    private func setupTableView(){
        tableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
