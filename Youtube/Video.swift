//
//  Video.swift
//  Youtube
//
//  Created by Thanh Tu Le Xuan on 6/12/17.
//  Copyright © 2017 Thanh Tu Le Xuan. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnaiImageName: String?
    var title: String?
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}



