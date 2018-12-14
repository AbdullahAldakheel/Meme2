//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Abdullah Aldakhiel on 09/12/2018.
//  Copyright © 2018 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var meme1: Meme!
    
    @IBOutlet weak var imgTmp: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTmp.image = meme1.memedImage
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressEdit(_ sender: Any) {
        performSegue(withIdentifier: "goEdit", sender: meme1)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goEdit" {
            let tmp = sender as? Meme
            
            let md = segue.destination as? ImgMaker
            md?.meme1 = tmp
            
        }
    }
    
    
    
}
