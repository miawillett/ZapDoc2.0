//
//  displayTextVC.swift
//  TEXType
//
//  Created by Rohan Daruwala on 3/31/16.
//  Copyright © 2016 ZapDoc. All rights reserved.
//

import UIKit

class displayTextVC: UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    
    var textToDisplay : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = textToDisplay
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
