//
//  HomeController.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/5/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?
    
    func fetchVideos(){
        
        APIService.sharedInstance.fetchVideos { (vd) in
            self.videos = vd
            self.collectionView?.reloadData()
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        //navigation
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        setupNavBarButtons()
        
        setupMenuBar()
        
        
        
        collectionView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cell")
        //Đẩy collection xuống
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        
    }
    
    func setupNavBarButtons(){
        
        let btnS = UIButton.init(type: .custom)
        btnS.setImage(#imageLiteral(resourceName: "search"), for: UIControlState.normal)
        
        btnS.addTarget(self, action: #selector(HomeController.handleSearch), for: .touchUpInside)
        
        btnS.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
        
        let searchButton = UIBarButtonItem(customView: btnS)
        
        
        
        let btnM = UIButton.init(type: .custom)
        btnM.setImage(#imageLiteral(resourceName: "more"), for: UIControlState.normal)
        
        btnM.addTarget(self, action: #selector(HomeController.handleMore), for: .touchUpInside)
        
        btnM.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
        
        let moreButton = UIBarButtonItem(customView: btnM)
        
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    func handleSearch() {
        
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    
    
    func handleMore() {
        //show menu
        settingsLauncher.showSettings()
        
    }
    
    func showControllerForSetting(setting :Setting){
        let dummySettingsViewController = UIViewController()
        
        dummySettingsViewController.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dummySettingsViewController.navigationItem.title = setting.name
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar() {
        
        let redView = UIView()
        redView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        //giấu navigation khi swipe
        navigationController?.hidesBarsOnSwipe = true
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
    
    
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VideoCell
        
        
        cell.video = videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 68 + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }


}
