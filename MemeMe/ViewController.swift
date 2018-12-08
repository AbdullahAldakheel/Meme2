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
    var imgTmp:UIImage!

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if imgCheck{
            if (segue.identifier == "grid1") {
                let orignalMeme = segue.destination as! ImgMaker
                orignalMeme.changeImg(img: imgTmp, top: "gggg", bot: "Ggg")

                
                
            }
        }

    }
    
	func bringMeme() -> [Meme] {
        return (UIApplication.shared.delegate as? AppDelegate)?.meme ?? []
    }
}

extension ViewController: UICollectionViewDelegate {}

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
        self.imgTmp = grid1.imgPoster.image
        self.imgCheck = true
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
