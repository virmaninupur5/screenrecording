//
//  GalleryCollectionViewCell.swift
//  ScreenRecording
//
//  Created by Noopur Virmani on 14/03/19.
//  Copyright © 2019 Noopur Virmani. All rights reserved.
//

import Foundation
import UIKit
import WebKit;

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
    func setView(url: URL){
        //let url = URL(fileURLWithPath: Bundle.main.path(forResource:"index", ofType: "html")!)
        webView.load(URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60*100))
    }
    
   
    
}
