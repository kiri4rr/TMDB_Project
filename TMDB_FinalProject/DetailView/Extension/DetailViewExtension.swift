//
//  DetailViewExtension.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 24.01.2023.
//

import UIKit
import YouTubeiOSPlayerHelper

extension DetailViewController: YTPlayerViewDelegate{
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        print("playerViewDidBecomeReady")
        loading.isHidden = true
        contentView.isHidden = false
        setupScrollView()
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print("receivedError error: YTPlayerError")
        loading.isHidden = true
        contentView.isHidden = false
        for constraint in self.youtubePlayer.constraints{
            if constraint.firstAttribute == .height {
                constraint.constant = 0
            }
        }
        setHeightOfContent()
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: heightOfContent).isActive = true
    }
}
