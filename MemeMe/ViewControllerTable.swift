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
			Meme2 = demoData()
			appDelegate?.meme = Meme2
		} else {
			Meme2 = appDelegate?.meme
		}
        
	}

	func demoData() -> [Meme] {
        return (UIApplication.shared.delegate as? AppDelegate)?.meme ?? []
    }
}

extension ViewControllerTable: UICollectionViewDelegate {}

extension ViewControllerTable: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return Meme2.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabelView", for: indexPath) as? CollectionViewTable else {
			fatalError("couldn't load cell for collection view")
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