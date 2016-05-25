//
//  OCR_VC.swift
//  TEXType
//
//  Created by Rohan Daruwala on 3/31/16.
//  Copyright © 2016 ZapDoc. All rights reserved.
//

import UIKit

class OCR_VC: UIViewController {

    @IBOutlet weak var viewImage: UIImageView!
    
    var recievedImage : UIImage!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var text:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let imageData = defaults.objectForKey("data") as! NSData
        recievedImage = UIImage(data: imageData)!
        
        viewImage.image = recievedImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onConvertButtonPress(sender: AnyObject) {
        performImageRecognition(scaleImage(recievedImage, maxDimension: 640))
        
        let vc = storyboard!.instantiateViewControllerWithIdentifier("displayTextVC") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSizeMake(maxDimension, maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    
    func performImageRecognition(image: UIImage) {
        // 1
        let tesseract = G8Tesseract()
        // 2
        tesseract.language = "eng+fra"
        // 3
        tesseract.engineMode = .TesseractCubeCombined
        // 4
        tesseract.pageSegmentationMode = .Auto
        // 5
        tesseract.maximumRecognitionTime = 60.0
        // 6
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        // 7
        
        text = tesseract.recognizedText
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! displayTextVC
        destination.textToDisplay = text
        
    }


}
