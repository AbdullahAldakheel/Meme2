//
//  ViewController.swift
//  MemeMe
//
//  Created by Abdullah Aldakhiel on 15/11/2018.
//  Copyright © 2018 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var imgCheck = false
	var grid: [Meme]!
    var Tmp:Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		if appDelegate?.meme == nil {
			grid = bringMeme()
			appDelegate?.meme = grid
		} else {
			grid = appDelegate?.meme
		}
        
	}

    
    
    

    
	func bringMeme() -> [Meme] {
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

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let memDetail = grid[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: "grid1", sender: memDetail)
    }
  
}

extension ViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return grid.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let grid1 = collectionView.dequeueReusableCell(withReuseIdentifier: "grid", for: indexPath) as? CollectionViewCell else {
			fatalError("")
		}
		let Meme = grid[indexPath.row]
		grid1.imgPoster.image = Meme.memedImage
        
    
		return grid1
	}
    

    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 10
        let cellWidth = width / 3
        return CGSize(width: cellWidth, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }


}



