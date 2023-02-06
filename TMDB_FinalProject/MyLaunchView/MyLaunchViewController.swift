//
//  MyLaunchViewController.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController{
    
    var viewModel: MyLaunchViewModel? = MyLaunchViewModel()
    
    deinit {
        print("\(LaunchViewController.self) deinited!")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConfig()
        let label = self.createLabel()
        self.view.addSubview(label)
        viewModel?.getListOfData { [weak self] in
            guard let self = self else {return}
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []) {
                label.alpha = 0
                
            } completion: { (completed) in
                self.addGif()
            }
        }
    }
    
    // MARK:- Set up config of View
    
    private func setUpConfig(){
        view.backgroundColor = .white
    }
    
    // MARK:- Create and add UILabel to View
    
    private func createLabel() -> UILabel{
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: self.view.frame.width,
                                          height: self.view.frame.height))
        label.tag = 0
        label.font = UIFont(name: "Bodoni 72 Book", size: 88)
        label.text = "TMDB"
        label.textAlignment = .center
        label.center = view.center
        label.textColor = .black
        
        return label
    }
    
    // MARK:- Create and add Lottie to View
    
    private func addGif(){
        view.addSubview(createGif())
        
    }
    
    private func createGif() -> LottieAnimationView{
        var animationView: LottieAnimationView
        animationView = .init(name: "Film")
        animationView.tag = 1
        
        animationView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.view.frame.width,
                                     height: self.view.frame.height)
        
        animationView.contentMode = .scaleAspectFit
        
        animationView.loopMode = .loop
        
        animationView.animationSpeed = 0.5
        animationView.currentProgress = 0.45
        animationView.play(fromProgress: 0.45,
                           toProgress: 1,
                           loopMode: .playOnce) { [weak self](completed) in
            guard let self = self else {return}
            self.present(MainTabBarViewController(), animated: true, completion: nil)
        }
        
        return animationView
    }
    
}
