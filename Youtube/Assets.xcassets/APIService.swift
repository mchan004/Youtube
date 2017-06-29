//
//  APIService.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/25/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class APIService: NSObject {

    static let sharedInstance = APIService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
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
                    var videos = [Video]()
                    for dictionary in js as! [[String: AnyObject]] {
                        let video = Video()
                        video.title = dictionary["title"] as? String
                        
                        video.thumbnaiImageName = dictionary["thumbnaiImage"] as? String
                        
                        let channel = Channel()
                        channel.name = dictionary["channel"]?["name"] as? String
                        channel.profileImageName = dictionary["channel"]?["profileImageName"] as? String
                        video.channel = channel
                        videos.append(video)
                    }
                    
                    //ReloadData collectionView
                    DispatchQueue.main.async {
                        if (Thread.isMainThread) {
                            
                            completion(videos)
                        }
                    }
                    
                    
                    
                    
                }
                catch let jsonError {
                    print(jsonError)
                }
            }
            }.resume()
        
    }

    
}
