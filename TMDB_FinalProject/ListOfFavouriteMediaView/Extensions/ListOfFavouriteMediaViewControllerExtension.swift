//
//  ListOfFavouriteMediaViewControllerExtension.swift
//  TMDB
//
//  Created by Kirill Romanenko on 03.01.2023.
//

import UIKit
import SDWebImage

extension ListOfFavouriteMediaViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.favouriteMediaModel?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell",
                                                    for: indexPath) as? FavouriteTableViewCell{
            guard let arrayOfFavouriteMedia = viewModel?.favouriteMediaModel else {return UITableViewCell()}
            let URLStr: String = Constants.singelton.getURLForPictureWeight200(arrayOfFavouriteMedia[indexPath.row].URLStringOfImage)
            cell.cellImageView.sd_setImage(with: URL(string: URLStr), completed: nil)
            cell.label.text = arrayOfFavouriteMedia[indexPath.row].name
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
}

extension ListOfFavouriteMediaViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(220)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailViewController()
        guard let arrayOfFavouriteMedia = viewModel?.favouriteMediaModel else {return}
        controller.viewModel?.name = arrayOfFavouriteMedia[indexPath.row].name
        let presentController = UINavigationController(rootViewController: controller)
        presentController.modalPresentationStyle = .fullScreen
        self.present(presentController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){_,_,_ in
            self.tableView.beginUpdates()
            self.viewModel?.deleteFromFavourite(index: indexPath.row) {
                self.tableView.deleteRows(at: [indexPath], with: .top)
                self.tableView.reloadData()
                self.tableView.endUpdates()
            }
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
}
