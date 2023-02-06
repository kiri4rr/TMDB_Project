//
//  MainTabBarViewController.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addControllers()
        modalPresentationStyle = .fullScreen
        
    }
    
    //MARK:- Configure TabBar
    
    private func addControllers(){
        viewControllers = [
            createNavigationViewController(ListOfMediaViewController(),
                                           "Films",
                                           UIImage(systemName: "film")!,
                                           UIImage(systemName: "film.fill")!),
            createNavigationViewController(ListOfFavouriteMediaViewController(),
                                           "Favourites",
                                           UIImage(systemName: "heart")!,
                                           UIImage(systemName: "heart.fill")!)
        ]
    }
    
    private func createNavigationViewController(_ rootController: UIViewController,
                                                _ title: String,
                                                _ image: UIImage,
                                                _ selectedImage: UIImage)
                                                -> UINavigationController{
        
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.selectedImage = selectedImage
        
        return navigationController
        
    }


}
