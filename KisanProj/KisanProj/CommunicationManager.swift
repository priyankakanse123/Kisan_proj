//
//  CommunicationManager.swift
//  KisanProj
//
//  Created by Priyanka Kanse on 15/01/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//
//constants
let errorString : String = "Unknown Error"

import UIKit

class CommunicationManager : NSObject, URLSessionDownloadDelegate {
    
    var url : URL?
    // will be used to do whatever is needed once download is complete
    var yourOwnObject : pCallback?
    
    init(_ yourOwnObject : pCallback)
    {
        self.yourOwnObject = yourOwnObject
    }
    
    //is called once the download is complete
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
    {
        //copy downloaded data to your documents directory with same names as source file
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //take out whether type
        //from path search weather type
        var whethrString : String = ""
        for (_ , value) in arrWeatherTypeDict
        {
            if("\(url!)".contains(value))
            {
                whethrString = value
                break
            }
        }

        
        
        let destinationUrl = documentsUrl!.appendingPathComponent("\(url!.lastPathComponent)_\(whethrString)")
        let dataFromURL = NSData(contentsOf: location)
        dataFromURL?.write(to: destinationUrl, atomically: true)
        
        //print("destt url =",destinationUrl)
        
        
        
        
        
        
        //send back success with default destination Url
        //self.yourOwnObject?.successCallBack(message: destinationUrl)
        
        self.readFile(destinationurl: destinationUrl)
        
        //now it is time to do what is needed to be done after the download
        //use it afterwords
        //yourOwnObject!.callWhatIsNeeded()
    }
    
    
    // if there is an error during download this will be called
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
    {
        if(error != nil)
        {
            //handle the error
            //print("Download completed with error: \(error!.localizedDescription)");
            self.yourOwnObject?.errorCallback(message: (error!.localizedDescription))
        }
    }
    
    //method to be called to download
    func download(url: URL,wetherType:String)
    {
        self.url = url
        
        //download identifier can be customized. I used the "ulr.absoluteString"
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: (url.absoluteString))
        let session = Foundation.URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        task.resume()
    }
    
    //read file
    func readFile(destinationurl : URL)
    {
        var readString = "" // Used to store the file contents
        do {
            // Read the file contents
            readString = try String(contentsOf: destinationurl)
        } catch let error as NSError {
            //print("Failed reading from URL: \(destinationurl), Error: " + error.localizedDescription)
            self.yourOwnObject?.errorCallback(message: (error.localizedDescription))

        }
        if(readString != "")
        {
            self.yourOwnObject?.successCallBackWithPath!(message: readString, path: "\(destinationurl)")
        }
        else
        {
            self.yourOwnObject?.errorCallback(message: errorString)
        }
        
    }

    


}


