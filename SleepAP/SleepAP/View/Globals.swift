//
//  Globals.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import Foundation
import Parse

// global functions
func convertToHourString(hour: Int, mins: Int) -> String {
    let hours = Double(hour) + Double(mins) / 60.0
    return hours.format(f: ".1")
}

func saveSleepStartTime(sleepStartDate: Date) {
    if let user = PFUser.current() {
        user["sleepStart"] = sleepStartDate
        user.saveInBackground {
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

func saveSleepHourDuration(sleepDurationString: String) {
    if let user = PFUser.current() {
        user["sleepDuration"] = Double(sleepDurationString)
        user.saveInBackground {
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

func saveSleepEndTime(sleepEndDate: Date) {
    if let user = PFUser.current() {
        user["sleepEnd"] = sleepEndDate
        user.saveInBackground {
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


func getSleepStartDate()->Date {
    let user = PFUser.current()
    return user?["sleepStart"] as! Date
}

func getSleepEndDate()->Date {
    let user = PFUser.current()
    return user?["sleepEnd"] as! Date
}

func getSleepDuration()->Double {
    let user = PFUser.current()
    return user?["sleepDuration"] as! Double
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
