//
//  ViewController.swift
//  CustomUIImagePicker
//
//  Created by Mauro on 4/4/15.
//  Copyright (c) 2015 mc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate  {

    @IBOutlet weak var image: UIImageView!
    @IBAction func photoAction(sender: AnyObject) {
        shootPhoto()
    }
    
    @IBAction func cameraRollAction(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    let imagePicker = UIImagePickerController()
    let flashButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dismiss(sender: UIButton!)
    {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
   
    func shootPhoto()
    {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            return
        }
        
        imagePicker.sourceType = .Camera
        imagePicker.showsCameraControls = false
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        
        
        //Picker View Custom Container
        let overlayView = UIView()
        
        // Width Constraint
        let overlayViewWidthContraints = NSLayoutConstraint(item: overlayView, attribute:.Width, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: screenWidth)
        
        // Height Constraint
        let overlayViewHeightContraints = NSLayoutConstraint(item: overlayView, attribute:
            .Height, relatedBy: .Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0,constant: screenHeight)
        
        // Horizontal Constraint
        let overlayViewConstraintHorizontal = NSLayoutConstraint(item: overlayView, attribute: .Leading , relatedBy: .Equal, toItem: view, attribute: .Leading , multiplier: 1, constant: 0)
        
        //Vertical Constraint
        let overlayViewConstraintVertical = NSLayoutConstraint(item: overlayView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top , multiplier: 1, constant: 0)
        self.view.addSubview(overlayView)
        

        //Black bar button container
        let imagePickerView:UIView = UIView();
        imagePickerView.backgroundColor = UIColor.blackColor()
        let imagePickerWidthContraints = NSLayoutConstraint(item: imagePickerView, attribute:.Width, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: screenWidth)
        let imagePickerHeightContraints = NSLayoutConstraint(item: imagePickerView, attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 44)
        let imagePickerViewConstraintHorizontal = NSLayoutConstraint(item: imagePickerView, attribute: .Leading , relatedBy: .Equal, toItem: overlayView, attribute: .Leading , multiplier: 1, constant: 0)
        let imagePickerViewConstraintVertical = NSLayoutConstraint(item: imagePickerView, attribute: .Top, relatedBy: .Equal, toItem: overlayView, attribute: .Top , multiplier: 1, constant: 0)
        overlayView.addSubview(imagePickerView)
        
        
        //Cancel button
        let cancelButton = UIButton()
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelButton.backgroundColor = UIColor.clearColor()
        cancelButton.addTarget(self, action: "dismiss:", forControlEvents: .TouchUpInside)
        
        //Width constraints
        let cancelWidthContraints = NSLayoutConstraint(item: cancelButton, attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 70)
        //Height constraints
        let cancelHeightContraints = NSLayoutConstraint(item: cancelButton, attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 44)
        //Horizontal constraints
        let cancelConstraintHorizontal = NSLayoutConstraint(item: cancelButton, attribute: .Leading , relatedBy: .Equal, toItem: imagePickerView, attribute: .Leading , multiplier: 1, constant: 0)
        //Vertical constraints
        let cancelConstraintVertical = NSLayoutConstraint(item: cancelButton, attribute: .Top, relatedBy: .Equal, toItem: imagePickerView, attribute: .Top , multiplier: 1, constant: 0)
        imagePickerView.addSubview(cancelButton)
        
        
        //Flash Image
        let flashImage = UIImageView()
        flashImage.image = UIImage(named: "flashIcon")
        //Width constraints
        let fImageWidthContraints = NSLayoutConstraint(item: flashImage, attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 12)
        //Height constraints
        let fImageHeightContraints = NSLayoutConstraint(item: flashImage, attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 16)
        //Horizontal constraints
        let fImageConstraintHorizontal = NSLayoutConstraint(item: flashImage, attribute: .Leading , relatedBy: .Equal, toItem: imagePickerView, attribute: .Leading , multiplier: 1, constant: screenWidth-68)
        //Vertical constraints
        let fImageConstraintVertical = NSLayoutConstraint(item: flashImage, attribute: .Top, relatedBy: .Equal, toItem: imagePickerView, attribute: .Top , multiplier: 1, constant: 14)
        //Adding it to the black bar view
        imagePickerView.addSubview(flashImage)

        
        //Flash button
        flashButton.setTitle("Auto", forState: .Normal)
        flashButton.backgroundColor = UIColor.clearColor()
        flashButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        flashButton.addTarget(self, action: "cameraFlashSetting:", forControlEvents: .TouchUpInside)
        
        //Width constraints
        let flashWidthContraints = NSLayoutConstraint(item: flashButton, attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60)
        //Height constraints
        let flashHeightContraints = NSLayoutConstraint(item: flashButton, attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 44)
        //Horizontal constraints
        let flashConstraintHorizontal = NSLayoutConstraint(item: flashButton, attribute: .Leading , relatedBy: .Equal, toItem: imagePickerView, attribute: .Leading , multiplier: 1, constant: screenWidth-62)
        //Vertical constraints
        let flashConstraintVertical = NSLayoutConstraint(item: flashButton, attribute: .Top, relatedBy: .Equal, toItem: imagePickerView, attribute: .Top , multiplier: 1, constant: 0)
        imagePickerView.addSubview(flashButton)


        //Shoot button
        let shotButton = UIButton()
        shotButton.setImage(UIImage(named: "cameraShutter"), forState: UIControlState.Normal)
        shotButton.layer.cornerRadius = 30
        shotButton.clipsToBounds = true
        shotButton.addTarget(self, action: "takingPicture:", forControlEvents: .TouchUpInside)
        
        //Width constraints
        let shootWidthContraints = NSLayoutConstraint(item: shotButton, attribute: .Width, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60)
        //Height constraints
        let shootHeightContraints = NSLayoutConstraint(item: shotButton, attribute: .Height, relatedBy: .Equal, toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 60)
        //Horizontal constraints
        let shootConstraintHorizontal = NSLayoutConstraint(item: shotButton, attribute: .Leading , relatedBy: .Equal, toItem: overlayView, attribute: .Leading , multiplier: 1, constant: screenWidth/2 - 30)
        //Vertical constraints
        let shootConstraintVertical = NSLayoutConstraint(item: shotButton, attribute: .Top, relatedBy: .Equal, toItem: overlayView, attribute: .Top , multiplier: 1, constant: screenHeight - 80)
        //adding it to the custom view
        overlayView.addSubview(shotButton)
        
        
        // Don't forget to set this property on the contrary you'll never see th controls!
        shotButton.translatesAutoresizingMaskIntoConstraints = false
        flashButton.translatesAutoresizingMaskIntoConstraints = false
        flashImage.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        imagePickerView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Collect all the contraints and make them to be active
        NSLayoutConstraint.activateConstraints([imagePickerWidthContraints, imagePickerHeightContraints, imagePickerViewConstraintHorizontal, imagePickerViewConstraintVertical, overlayViewWidthContraints, overlayViewHeightContraints, overlayViewConstraintHorizontal, overlayViewConstraintVertical, cancelWidthContraints, cancelHeightContraints, cancelConstraintHorizontal, cancelConstraintVertical, fImageWidthContraints, fImageHeightContraints, fImageConstraintHorizontal, fImageConstraintVertical, flashWidthContraints, flashHeightContraints, flashConstraintHorizontal, flashConstraintVertical, shootWidthContraints, shootHeightContraints, shootConstraintHorizontal, shootConstraintVertical])
        
        imagePicker.cameraOverlayView = overlayView
        overlayView.backgroundColor = UIColor.clearColor()
        overlayView.opaque = false
        
        //these are the custom setting to use all the screen as camera eye
        let cameraAspectRatio:Float = 4.0 / 3.0;
        let imageWidth = floorf(Float(screenWidth) * cameraAspectRatio)
        let scale = ceilf((Float(screenHeight) / imageWidth) * 10.0) / 8.5;
        imagePicker.cameraViewTransform = CGAffineTransformMakeScale(CGFloat(scale), CGFloat(scale));
        
        presentViewController(imagePicker, animated: false, completion: nil)
    }

    
    func takingPicture(sender: UIButton!)
    {
        imagePicker.takePicture()
    }
  
    func cameraFlashSetting(sender: UIButton!)
    {
        switch(imagePicker.cameraFlashMode.hashValue){
        case 0:
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.On
            self.flashButton.setTitle("On", forState: .Normal)
        case 1:
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Off
            self.flashButton.setTitle("Off", forState: .Normal)
        case 2:
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
            self.flashButton.setTitle("Auto", forState: .Normal)
        default:
            imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto
            self.flashButton.setTitle("Auto", forState: .Normal)
        }
    }
}

extension ViewController :UIImagePickerControllerDelegate {

    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        image.hidden = false
        let photoImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        image.image = photoImage
     }
}

