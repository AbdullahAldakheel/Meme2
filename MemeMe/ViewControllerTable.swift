//
//  ViewControllerTable.swift
//  MemeMe
//
//  Created by Abdullah Aldakhiel on 15/11/2018.
//  Copyright © 2018 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class ViewControllerTable: UIViewController {
    
    var Meme2: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if appDelegate?.meme == nil {
            Meme2 = bringData()
            appDelegate?.meme = Meme2
        } else {
            Meme2 = appDelegate?.meme
        }
        
    }
    
    
    func bringData() -> [Meme] {
        return (UIApplication.shared.delegate as? AppDelegate)?.meme ?? []
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "grid1" {
            let tmp = sender as? Meme
            
            let md = segue.destination as? MemeDetailsViewController
            md?.meme1 = tmp
            
        }
    }
    
}

extension ViewControllerTable: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memDetail = Meme2[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: "grid1", sender: memDetail)
    }
}

extension ViewControllerTable: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabelView", for: indexPath) as? CollectionViewTable else {
            fatalError("")
        }
        let Meme = Meme2[indexPath.row]
        cell.imgPoster.image = Meme.memedImage
        cell.topLabel.text = Meme.topText
        cell.botLabel.text = Meme.bottomText
        return cell
    }
}

extension ViewControllerTable: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: 90)
    }
}
