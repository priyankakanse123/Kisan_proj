//
//  ViewController.swift
//  KisanProj
//
//  Created by Priyanka Kanse on 15/01/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit
import WebKit
import MessageUI

class ViewController: UIViewController,pCallback,MFMailComposeViewControllerDelegate {
    
    var presenterObj : Presenter?       //presenter obj

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        
        self.hitDownloadButton()

    }
    
    
    
    func hitDownloadButton()
    {
        self.presenterObj = Presenter(pCallbackRef: self)
        self.presenterObj?.downloadFiles()
    }
    
    //implement protocol
    func successCallBack(message: String)
    {
        
    }
        
        
    func errorCallback(message:String)
    {
        //put alerview to show message

    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

