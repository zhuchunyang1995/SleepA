//
//  recordTableItemModel.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/21/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//
// Conform to MVVM structure
// Reference: https://medium.com/@stasost/ios-how-to-build-a-table-view-with-multiple-cell-types-2df91a206429

import Foundation

enum recordItemType {
    case slideBar
    case numberInput
}

protocol recordViewModelItems {
    var type: recordItemType { get }
    var rowCount: Int { get }
}

class slideBarItems: recordViewModelItems {
    var type: recordItemType {
        return .slideBar
    }
    var rowCount: Int {
        return slideBarArray.count
    }
    
    var slideBarArray: [slideBarItem]
    
    init(slideBarArray: [slideBarItem]) {
        self.slideBarArray = slideBarArray
    }
}

class numberInputItems: recordViewModelItems {
    var type: recordItemType {
        return .numberInput
    }
    var rowCount: Int {
        return numberInputNameArray.count
    }
    
    var numberInputNameArray: [String]
    
    init(numberInputNameArray: [String]) {
        self.numberInputNameArray = numberInputNameArray
    }
}

class slideBarItem {
    var slideBarItemName: String
    var slideBarItemImageName: String
    
    init(name: String, imageName: String) {
        self.slideBarItemName = name
        self.slideBarItemImageName = imageName
    }
}

class recordViewModel: NSObject {
    var recordItems = [recordViewModelItems]()
    
    let slideBar = [slideBarItem(name: "Sleep Quality", imageName: "sleep"),
                         slideBarItem(name: "Health", imageName: "health"),
                         slideBarItem(name: "Productivity", imageName: "productivity"),
                         slideBarItem(name: "Energy", imageName: "energy"),
                         slideBarItem(name: "Mood", imageName: "mood")]
    
    let nameInputItems = ["Weight", "Blood Pressure", "Heart Rate"]
    
    override init() {
        super.init()
        
        recordItems.append(slideBarItems(slideBarArray: slideBar))
        recordItems.append(numberInputItems(numberInputNameArray: nameInputItems))
    }
}


