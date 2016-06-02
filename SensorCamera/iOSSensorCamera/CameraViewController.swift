//
//  CameraViewController.swift
//  iOSSensorCamera
//
//  Created by Thomas Attermann on 28/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let picker = UIImagePickerController()
    
    var avPlayerViewController = AVPlayerViewController()
    var movieURL:NSURL?
    
    var image:UIImage?
    var avPlayerView:UIView?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Camera"

    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Button for chosing to use the camera - calls pickMediaFromSoruce method (defined at bottom)

    @IBAction func buttonNewImage(sender: AnyObject) {
        pickMediaFromSource(UIImagePickerControllerSourceType.Camera)

    }
    
    // Button for chosing an existing image/video from library - calls pickMediaFromSoruce method (defined at bottom)
    @IBAction func buttonImageFromAlbum(sender: AnyObject) {
        pickMediaFromSource(UIImagePickerControllerSourceType.PhotoLibrary)

    }
    
    // Delegate method for getting a hold of whatever media was selected.
    func imagePickerController(picker_: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // The last chosen media selected
        let chosenMediaType = info[UIImagePickerControllerMediaType] as? String
        
        // Check for media type
        if chosenMediaType == kUTTypeImage as String {
            //let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
            image = info[UIImagePickerControllerEditedImage] as? UIImage
            
            imageView.contentMode = .ScaleAspectFit
            imageView.image = image
            imageView.hidden = false
            avPlayerViewController.view.hidden = true
        }
        
        if chosenMediaType == kUTTypeMovie as String {
            movieURL = info[UIImagePickerControllerMediaURL] as? NSURL
            // Play video
            imageView.hidden = true
            avPlayerViewController.view.hidden = false
            playVideo()
            
        }
        
        // Skift til UUImagePickerControllerOriginal image hvis original skal bruges.
        if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = chosenImage
        }
        
        picker_.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // Method for showing video when selected.
    func playVideo() {
        avPlayerView = avPlayerViewController.view!
        avPlayerView?.frame = imageView.frame
        view.addSubview(avPlayerView!)
        avPlayerViewController.player = AVPlayer(URL: movieURL!)
        avPlayerViewController.player?.play()
    }
    
    // Method for chosing whether to bring up camera or image library - used in button actions.
    func pickMediaFromSource(sourceType: UIImagePickerControllerSourceType) {
        
        // Variable for holding chosen mediatype
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
        
        // Prepare picker for chosen media
        picker.mediaTypes = mediaTypes!
        picker.sourceType = sourceType
        picker.delegate = self
        
        // Scaling
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
        
    }




}
