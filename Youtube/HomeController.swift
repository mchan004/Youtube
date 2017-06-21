//
//  HomeController.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/5/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "Thanh Tu"
//        kanyeChannel.profileImageName = "ava"
//        
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "[Offical MV] Đưa nhau đi trốn - Đen ft. Linh Cáo (Prod. by Suicidal illness)"
//        blankSpaceVideo.thumbnaiImageName = "jangmi"
//        blankSpaceVideo.channel = kanyeChannel
//        
//        var badBloodVideo = Video()
//        badBloodVideo.title = "FAPtv Cơm Nguội: Tập 114"
//        badBloodVideo.thumbnaiImageName = "jangmi"
//        badBloodVideo.channel = kanyeChannel
//        
//        return [blankSpaceVideo, badBloodVideo]
//    }()

    
    var videos: [Video]?
    
    func fetchVideos(){
        let url = URL(string: "https://dvmaytinh.com/json.php")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let dt = data
            {
                do
                {
                    let js = try JSONSerialization.jsonObject(with: dt, options: .mutableContainers)
                    self.videos = [Video]()
                    for dictionary in js as! [[String: AnyObject]] {
                        let video = Video()
                        video.title = dictionary["title"] as? String
                        
                        video.thumbnaiImageName = dictionary["thumbnaiImage"] as? String
                        
                        let channel = Channel()
                        channel.name = dictionary["channel"]?["name"] as? String
                        channel.profileImageName = dictionary["channel"]?["profileImageName"] as? String
                        video.channel = channel
                        self.videos?.append(video)
                    }
                    
                    //ReloadData collectionView
                    DispatchQueue.main.async {
                        if (Thread.isMainThread) {
                            self.collectionView?.reloadData()

                        }
                    }
                    
                    
                    
                    
                }
                catch let jsonError {
                    print(jsonError)
                }
            }
        }.resume()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        //navigation
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
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
    
    let settingsLauncher = SettingsLauncher()
    
    func handleMore() {
        //show menu
        settingsLauncher.showSettings()
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
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
