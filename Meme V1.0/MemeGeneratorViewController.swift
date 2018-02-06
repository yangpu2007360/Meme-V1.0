//
//  ViewController.swift
//  Meme V1.0
//
//  Created by pu yang on 1/27/18.
//  Copyright © 2018 pu yang. All rights reserved.
//

import UIKit

class MemeGeneratorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var share: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var camera: UIBarButtonItem!
    @IBOutlet weak var album: UIBarButtonItem!
    
    
    let imagePicker = UIImagePickerController()
    let bottomDelegate = BottomTextFieldDelegate()
    var savedMeme : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure(textField: topTextField, withText: "TOP")
        configure(textField: bottomTextField, withText: "BOTTOM")
        camera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }


    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        presentImagePickerWith(sourceType: .camera)
    }
    
    @IBAction func albumButtonPressed(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {

        savedMeme = generateMemedImage()
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [savedMeme], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler =
            {
                (activityType,completed,items,errors) in
                if(completed)
                {
                    self.save()
                    print("save successfully")
                    activityViewController.dismiss(animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
        }
        
        let view = storyboard?.instantiateViewController(withIdentifier: "MemeTableViewController")
        self.present(view!, animated: true, completion: nil)
   
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let userPickedImage = info[UIImagePickerControllerOriginalImage]
        imageView.image = userPickedImage as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
           view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = 0
        }
        
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func generateMemedImage() -> UIImage {
        
        hideTopAndBottomBars(true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideTopAndBottomBars(false)
        
        return memedImage
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: savedMeme)
        
        // Add it to the memes array on the Application Delegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)

        
    }
    
    func configure(textField: UITextField, withText text: String) {
        
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: -3]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        
        textField.text = text
        imagePicker.delegate = self
        
        if textField == topTextField {
           topTextField.delegate = self
        }
        else {
            bottomTextField.delegate = bottomDelegate
        }
        

    }
    
    func presentImagePickerWith(sourceType: UIImagePickerControllerSourceType) {
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
    
    func hideTopAndBottomBars(_ hide: Bool) {
       
        toolbar.isHidden = hide
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
 
    }

    
}

