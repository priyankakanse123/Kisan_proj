//
//  Utils.swift
//  KisanProj
//
//  Created by Priyanka Kanse on 16/01/18.
//  Copyright © 2018 Priyanka Kanse. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
}



//Constants
var arrWeatherTypeDict = ["Max Temp":"Tmax","Min Temp":"Tmin","Mean Temp":"Tmean","Sunshine":"Sunshine","Rainfall":"Rainfall"]
var arrWeatherCountry = ["UK", "England", "Wales","Scotland"]


//tmax //https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmax/date/UK.txt
//tmin//https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmin/date/UK.txt
//tmean//https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Tmean/date/UK.txt
//sunshine//https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Sunshine/date/UK.txt
//rainfall//https://www.metoffice.gov.uk/pub/data/weather/uk/climate/datasets/Rainfall/date/UK.txt


extension String {
    
    //remove many white spaces to single white space
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

