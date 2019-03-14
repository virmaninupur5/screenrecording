//
//  GalleryVC.swift
//  ScreenRecording
//
//  Created by Noopur Virmani on 14/03/19.
//  Copyright © 2019 Noopur Virmani. All rights reserved.
//

import Foundation
import UIKit


class GalleryVC: UIViewController {
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    private var gallery = [URL]()
    private let reuseIdentifier = "GalleryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Album"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped));
        
        self.gallery = ReplayFileUtil.fetchAllReplays();
        
        print(ReplayFileUtil.fetchAllReplays());
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func doneTapped(){
        self.dismiss(animated: true, completion: nil);
    }
    
}

extension GalleryVC: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return gallery.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,for:indexPath) as! GalleryCollectionViewCell
        cell.backgroundColor = .black
        DispatchQueue.main.async {
            cell.setView(url: self.gallery[indexPath.row]);
        }
        
        // Configure the cell
        return cell
    }
    
    
    
    
}
