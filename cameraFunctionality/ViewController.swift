//
//  ViewController.swift
//  cameraFunctionality
//
//  Created by anil kumar srivastava on 8/3/17.
//  Copyright © 2017 camera. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    @IBOutlet weak var showImage = UIImageView()
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func galleryAction(_ sender: Any) {
         self.showImageSourceActionSheet()
           }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
        let tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        showImage?.image  = tempImage
        
        dismiss(animated: true, completion: nil)

        
    }
    
    
       
    fileprivate func showImageSourceActionSheet() {
        
        // create alert controller having style as ActionSheet
        let alertCtrl = UIAlertController(title: "Select Image Source" , message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        // create photo gallery action
        let galleryAction = UIAlertAction(title: "Photo Gallery", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.showPhotoGallery()
        }
        )
        
        // create camera action
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.showCamera()
        }
        )
        
        // create cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // add action to alert controller
        alertCtrl.addAction(galleryAction)
        alertCtrl.addAction(cameraAction)
        alertCtrl.addAction(cancelAction)
        
        // do this setting for ipad
        alertCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = alertCtrl.popoverPresentationController
        //popover?.UIButton = self.cameraButton
        
        
        // present action sheet
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    
    // Show photo gallery to choose image
    fileprivate func showPhotoGallery() -> Void {
        
        // debug
        print("Choose - Photo Gallery")
        
        // show picker to select image form gallery
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            // create image picker
            let imagePicker = UIImagePickerController()
            
            // set image picker property
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = ["public.image" , "public.movie"]
            
            //imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            // do this settings to show popover within iPad
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            let popover = imagePicker.popoverPresentationController
            //popover!.UIButton = self.cameraButton
            showImage?.isHidden = false

            // show image picker
            self.present(imagePicker, animated: true, completion: nil)
            
        }else{
            
            
            
            
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Device can not access gallery.")
        }
        
    }
    
    
    // Show camera to capture image
    fileprivate func showCamera() -> Void {
        
        // debug
        print("Choose Camera")
        
        // show camera
        if( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            // create image picker
            let imagePicker = UIImagePickerController()
            
            // set image picker property
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            imagePicker.allowsEditing = false
            
            // do this settings to show popover within iPad
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            let popover = imagePicker.popoverPresentationController
            //  popover!.barButtonItem = self.cameraButton
            
            // show image picker with camera.
            self.present(imagePicker, animated: true, completion: nil)
            
        }else {
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Camera not supported in emulator.")
        }
        
    }
    func showAlertMessage(alertTitle: String, alertMessage: String) {
        
        showImage?.isHidden = true
        
        let myAlertVC = UIAlertController( title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlertVC.addAction(okAction)
        
        self.present(myAlertVC, animated: true, completion: nil)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

