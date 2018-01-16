//
//  Presenter.swift
//  KisanProj
//
//  Created by Priyanka Kanse on 15/01/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

@objc protocol pCallback {
    func successCallBack(message: String)
    func errorCallback(message:String)
    @objc optional  func successCallBackWithPath(message: String,path:String)
    @objc optional  func shareSucceessCSV(path:URL)


}

class Presenter: NSObject,pCallback {
    
    var delegate : pCallback?
    var csvText : String? = ""
    
    
    init(pCallbackRef:pCallback)
    {
        self.delegate = pCallbackRef
    }

    
    //MARK:1.download text file
    func downloadFiles()
    {
        
        
            for countryName in arrWeatherCountry
            {
                for (_,value) in arrWeatherTypeDict
                {
                    let url = URL(string: "https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/\(value)/date/\(countryName).txt")
                    CommunicationManager(self).download(url: url!,wetherType: value)

                }

            }

    }
    
    
    //MARK:2.read text file
    //implement protocol
    func successCallBackWithPath(message: String,path:String)
    {
        //convert
        let array = message.components(separatedBy: .newlines)
        self.seperateArrayFurther(array: array,weatherType:path)
    }
    
    func successCallBack(message: String)
    {
        
    }
    func errorCallback(message:String)
    {
        
    }

    
    //parse data
    func seperateArrayFurther(array:[String],weatherType:String)
    {
        var innerdataArray = [[String]]()
        for i in 0..<array.count
        {
            let strToArray = array[i].condenseWhitespace()
            //made sub array of each main array
            let tempArray = (strToArray).components(separatedBy: " ")
            innerdataArray.append(tempArray)
            
            //check first element of an array is "Year"
            if(tempArray.count > 0)
            {
                if (tempArray[0]) == "Year"
                {
                    innerdataArray.removeAll()
                    innerdataArray.append(tempArray)
                    
                }
            }

        }
        
        self.createCSVFile(innerdataArray: innerdataArray,weatherType:weatherType)
        
        
    }
    
    
    
    //MARK:3.make CSV file and write the data
    func createCSVFile(innerdataArray : [[String]],weatherType:String)
    {
        //create .csv file
        let fileName = "weather.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName) //CSV file path
        print(path)

        
        
        //whether type
        var whethrString : String = ""
        
        //from path search weather type
        for (key , value) in arrWeatherTypeDict
        {
            if(weatherType.contains(value))
            {
                whethrString = key
                break
            }
        }
        
        //country type
        var contryString : String = ""
        
        //from path search weather type
        for countryname in arrWeatherCountry
        {
            if(weatherType.contains(countryname))
            {
                contryString = countryname
                break
            }
        }

        

        
        if(innerdataArray.count>0)
        {
            let monthsArray:[String] = innerdataArray[0]
        
            //write in .csv file
            for row in 1..<(innerdataArray.count-1) {
                
                let rowArray : [String] = innerdataArray[row]
                
                if(rowArray.count > 1)
                {
                
                    for subRow in 1..<(rowArray.count-1) {
                        
                        let newLine = "\(contryString),\(whethrString),\(rowArray[0]),\(monthsArray[subRow]),\(rowArray[subRow])\n"
                        self.csvText?.append(newLine)
                        
                        if(subRow == 12)
                        {
                            break
                        }

                    }
                }

                
            }
        }
        
        //write into csv file
        do {
            try csvText?.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            //print("errorrrr",error)
            self.delegate?.errorCallback(message: error as! String)
            return
        }
        
        
    }
    
}
