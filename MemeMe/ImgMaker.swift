//
//  ImgMaker.swift
//  MemeMe
//
//  Created by Abdullah Aldakhiel on 15/11/2018.
//  Copyright © 2018 Abdullah Aldakhiel. All rights reserved.
//

import UIKit

class ImgMaker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var meme1: Meme!
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var bottomBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var bottomPress = false
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.isEnabled = false
     
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        configureTextField (textF: bottomText, name: "BOTTOM")
        configureTextField (textF: topText, name: "TOP")
        if meme1 != nil {
            imagePickerView.image = meme1.originalImage
            configureTextField (textF: bottomText, name: meme1.bottomText)
            configureTextField (textF: topText, name: meme1.topText)
            shareButton.isEnabled = true
        }
        
    }
    
    func configureTextField (textF: UITextField, name: String){
        textF.text = name
        let memeTextAttributes:[NSAttributedString.Key : Any] = [
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -2.0,]
        textF.defaultTextAttributes = memeTextAttributes
        
        let fixedWidth = imagePickerView.frame.size.width
        let newSize = textF.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        textF.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        
    }
    @IBAction func sizeOfText(_ sender: Any) {
    }
    
    func changeImg(img : UIImage, top : String, bot: String){

        let selectImage:UIImage =  img
        
            self.imagePickerView.image = selectImage
            topText.text = top
            bottomText.text = bot
            
            
        }

        
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        
        super.touchesBegan(touches, with: event)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(ImgMaker.keyboardwillshow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        if bottomText.endEditing(true){
            NotificationCenter.default.addObserver(self, selector: #selector(ImgMaker.keyboardwillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
        }
    }
    
    @objc func keyboardwillshow (_ notification:Notification){
        if self.view.frame.origin.y == 0 && bottomText.isFirstResponder {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
            print(getKeyboardHeight(notification))
        }
    }
    @objc func keyboardwillHide(_ notification:Notification){
        
        self.view.frame.origin.y = 0
        
    }
    
    @IBAction func pickImage(_ sender: Any) {
        configurePicture(type: UIImagePickerController.SourceType.photoLibrary)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        configurePicture(type: UIImagePickerController.SourceType.camera)
    }
    
    func configurePicture(type: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        shareButton.isEnabled = true
        
    }
    
    @IBAction func keyBoardUp(_ sender: Any) {
        subscribeToKeyboardNotifications()
        
    }
    
    @IBAction func keyBoardDown(_ sender: Any) {
        unsubscribeFromKeyboardNotifications()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectImage: UIImage?
        if let image = info[UIImagePickerController.InfoKey.originalImage ] as? UIImage{
            
            selectImage = image
            self.imagePickerView.image = selectImage!
            picker.dismiss(animated: true, completion: nil)
            
        }else if let blankImage = info[.originalImage] as? UIImage {
            
            selectImage = blankImage
            self.imagePickerView.image = selectImage!
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        imagePickerView.image = nil
        bottomText.text = ""
        topText.text = ""
        
    }
    
    @IBAction func shareYourPic(_ sender: Any) {
        let memedImage = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        vc.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }
        }
        save()

        present(vc, animated: true)
       // dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "GoMain", sender: "1")


    }
    
    func save() {
        
        let imageObject = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage() )
        (UIApplication.shared.delegate as? AppDelegate)?.meme.append(imageObject)
        
 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoMain" {
            
           segue.destination as? ViewController
        }
    }

    
    func generateMemedImage() -> UIImage {
        
        topBar.isHidden = true
        bottomBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        topBar.isHidden = false
        bottomBar.isHidden = false
        return memedImage
    }
}


