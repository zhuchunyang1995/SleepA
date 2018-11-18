//
//  Globals.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import Foundation
import Parse

// global variables
var sleepStart : Date = Date()
var sleepEnd : Date = Date()
var sleepDurationString : String = ""
var isSleeped : Bool = false
var isReported : Bool = false

// global functions
func convertToHourString(hour: Int, mins: Int) -> String {
    let hours = Double(hour) + Double(mins) / 60.0
    return hours.format(f: ".1")
}

func saveSleepHours() {
    //save data to backend
    if let user = PFUser.current() {
        user["lastNightSleepHour"] = Double(sleepDurationString)
        let sleephr = PFObject(className:"SleepHour")
        sleephr["user"] = user
        sleephr["sleepHour"] = Double(sleepDurationString)
        user.saveInBackground {
            (success, error) in
            if (success) {
                // The object has been saved.
                // ToDo: jump to the main page
            } else {
                // There was a problem, check error.description
            }
        }
        sleephr.saveInBackground {
            (success, error) in
            if (success) {
                // The object has been saved.
                // ToDo: jump to the main page
            } else {
                // There was a problem, check error.description
            }
        }
    }
}

// If today is Monday, update the data
func weeklyUpdate() {
    // TODO: transfer time zone
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
//    dateFormatter.timeZone = NSTimeZone.local
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
    if (dateFormatter.string(from: Date()) == "Mon") {
        if let user = PFUser.current() {
            let weeklyHour = user["weeklyHour"]
            let weeklyScore = user["weeklyScore"]
            let last7SleepHour = user["last7SleepHour"]
            let last7AverageScore = user["last7AverageScore"]
        }
    }
    
    

    
}
