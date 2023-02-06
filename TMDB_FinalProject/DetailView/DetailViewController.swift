//
//  DetailViewController.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import UIKit
import YouTubeiOSPlayerHelper
class DetailViewController: UIViewController{
    
    var viewModel: DetailViewModel? = DetailViewModel()
    let youtubePlayer = YTPlayerView()
    
    let loading = UIActivityIndicatorView()
    
    var scrollView: UIScrollView = UIScrollView()
    var contentView: UIView = UIView()
    
    var imageView: UIImageView = UIImageView()
    var labelName: UILabel = UILabel()
    var labelOverView: UILabel = UILabel()
    var labelVoteAvarage: UILabel = UILabel()
    var labelVoteCount: UILabel = UILabel()
    var labelFirstAirDate: UILabel = UILabel()
    
    var heightOfContent: CGFloat = CGFloat(0)
    var index = 0
    
    deinit {
        print("\(DetailViewController.self) deinited!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtubePlayer.delegate = self
        
        contentView.isHidden = true
        loading.frame.size = CGSize(width: CGFloat(500), height: CGFloat(500))
        loading.center = self.view.center
        self.view.addSubview(loading)
        loading.startAnimating()
        
        setupConfigOfView()
        viewModel?.setKeyOfTrailer { [weak self] in
            guard let self = self else {return}
            guard let detailModel = self.viewModel?.detailModel else {return}
            self.setView(detailModel: detailModel)
        }
        
    }
    
    func setView(detailModel: DetailModel){
        youtubePlayer.load(withVideoId: detailModel.keyOfTrailer)
        setupImageView(detailModel.URLStringOfImage)
        setupLabelName(detailModel.name)
        setupLabelOverView(detailModel.overview)
        setupYoutubePlayer(detailModel.keyOfTrailer)
        setupLabelVoteAvarage(detailModel.voteAvarage)
        setupLabelVoteCount(detailModel.voteCount)
        setupLabelFirstAirDate(detailModel.firstAirDate)
    }
    
    // MARK:- Setup configuration of DetailViewController
    private func setupConfigOfView(){
        
        self.view.backgroundColor = .white
        modalPresentationStyle = .fullScreen
        self.title = "Details"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(doCancel))
        if !(viewModel?.checkIsFavourite() ?? false) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addToFavourites))
        }else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .remove, style: .plain, target: self, action: #selector(deleteFromFavourites))
        }
    }
    
    @objc private func doCancel(target: UIBarButtonItem){
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addToFavourites(target: UIBarButtonItem){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .remove,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.deleteFromFavourites))
        viewModel?.addMediaToFavourite()
    }
    
    @objc private func deleteFromFavourites(target: UIBarButtonItem){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.addToFavourites))
        viewModel?.deleteMediaFromFavourite()
    }
    
    // MARK:- Setup configuration of ScrollView
    func setupScrollView(){
        setHeightOfContent()
        scrollView.contentSize = CGSize(width: self.view.frame.width,
                                        height: heightOfContent + CGFloat(250))
        scrollView.frame = view.bounds
        contentView.frame.size = scrollView.contentSize
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    func setHeightOfContent(){
        for viewItem in contentView.subviews {
            for item in viewItem.constraints {
                if item.firstAttribute == .height {
                    heightOfContent += item.constant
                }
            }
        }
    }
    
    // MARK:- Setup configuration of ImageView
    func setupImageView(_ stringURL: String){
        imageView.backgroundColor = .gray
        imageView.sd_setImage(with: URL(string: Constants.singelton.getURLForPictureWeight500(stringURL)), completed: nil)
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 390).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    // MARK:- Setup configuration of LabelName
    func setupLabelName(_ name: String){
        labelName.text = name
        labelName.numberOfLines = 0
        labelName.font = UIFont.boldSystemFont(ofSize: 30.0)
        labelName.textColor = .black
        
        contentView.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        labelName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
        labelName.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
    }
    
    // MARK:- Setup configuration of LabelOverView
    func setupLabelOverView(_ overview: String){
        labelOverView.text = overview
        labelOverView.textAlignment = .justified
        labelOverView.numberOfLines = 0
        labelOverView.font = UIFont.systemFont(ofSize: 15.0)
        labelOverView.textColor = .black
        
        contentView.addSubview(labelOverView)
        labelOverView.translatesAutoresizingMaskIntoConstraints = false
        labelOverView.topAnchor.constraint(equalTo: labelName.bottomAnchor).isActive = true
        labelOverView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
        labelOverView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
    }
    
    // MARK:- Setup configuration of YoutubePlayer
    func setupYoutubePlayer(_ keyOfTrailer: String){
        
        if keyOfTrailer != ""{
            youtubePlayer.delegate = self
            let playerVars: [AnyHashable:Any] = ["autoplay": 0]
            youtubePlayer.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(youtubePlayer)
            
            youtubePlayer.load(withVideoId: keyOfTrailer, playerVars: playerVars)
            
            youtubePlayer.heightAnchor.constraint(equalToConstant: 250).isActive = true
            youtubePlayer.topAnchor.constraint(equalTo: labelOverView.bottomAnchor).isActive = true
            youtubePlayer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
            youtubePlayer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
        }else {
            youtubePlayer.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(youtubePlayer)
            
            youtubePlayer.heightAnchor.constraint(equalToConstant: 0).isActive = true
            youtubePlayer.topAnchor.constraint(equalTo: labelOverView.bottomAnchor).isActive = true
            youtubePlayer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
            youtubePlayer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
        }
    }
    
    // MARK:- Setup configuration of LabelVoteAvarage
    func setupLabelVoteAvarage(_ voteAvarage: String){
        labelVoteAvarage.text = "Vote avarege: \(voteAvarage)"
        labelVoteAvarage.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelVoteAvarage.textColor = .black
        
        contentView.addSubview(labelVoteAvarage)
        labelVoteAvarage.translatesAutoresizingMaskIntoConstraints = false
        labelVoteAvarage.topAnchor.constraint(equalTo: youtubePlayer.bottomAnchor).isActive = true
        labelVoteAvarage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
        labelVoteAvarage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
    }
    
    // MARK:- Setup configuration of LabelVoteCount
    func setupLabelVoteCount(_ voteCount: String){
        labelVoteCount.text = "Vote count: \(voteCount)"
        labelVoteCount.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelVoteCount.textColor = .black
        
        contentView.addSubview(labelVoteCount)
        labelVoteCount.translatesAutoresizingMaskIntoConstraints = false
        labelVoteCount.topAnchor.constraint(equalTo: labelVoteAvarage.bottomAnchor).isActive = true
        labelVoteCount.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
        labelVoteCount.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
    }
    
    // MARK:- Setup configuration of LabelFirstAirDate
    func setupLabelFirstAirDate(_ firstAirDate: String){
        labelFirstAirDate.text = "First air date: \(firstAirDate)"
        labelFirstAirDate.font = UIFont.boldSystemFont(ofSize: 20.0)
        labelFirstAirDate.textColor = .black
        
        contentView.addSubview(labelFirstAirDate)
        labelFirstAirDate.translatesAutoresizingMaskIntoConstraints = false
        labelFirstAirDate.topAnchor.constraint(equalTo: labelVoteCount.bottomAnchor).isActive = true
        labelFirstAirDate.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: CGFloat(3)).isActive = true
        labelFirstAirDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: CGFloat(-3)).isActive = true
    }
    
}

