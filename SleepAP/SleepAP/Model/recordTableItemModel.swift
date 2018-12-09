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

class slideBarItem {
    var slideBarItemName: String
    var slideBarItemImageName: String
    var levels : [String]
    
    init(name: String, imageName: String, levels: [String]) {
        self.slideBarItemName = name
        self.slideBarItemImageName = imageName
        self.levels = levels
    }
}

class recordViewModel: NSObject {
    var recordItems = [recordViewModelItems]()
    
    let slideBar = [slideBarItem(name: "Sleep", imageName: "sleep", levels:["Tossed and turned all night","Waked up at times","Slept without interruption","A refreshing sleep"]),
                    slideBarItem(name: "Health", imageName: "health", levels:["Feel strong pains in body","A little uncomfortable","Feeling normal","Feeling healthy and fit"]),
                    slideBarItem(name: "Productivity", imageName: "productivity", levels:["Nothing accomplished","Accomplished a little","Much of work done", "Goal 100% accomplished"]),
                    slideBarItem(name: "Energy", imageName: "energy",levels:["Excessive sleepiness","Fatigue most of time","Feeling good","Very energetic and refreshing"]),
                    slideBarItem(name: "Mood", imageName: "mood",levels:["Depressed and irritated","Moodiness","Feeling OK","Happy and tranquil"])
    ]
    
    override init() {
        super.init()
        recordItems.append(slideBarItems(slideBarArray: slideBar))
    }
}

class cellSingleton {
    static let sharedInstance = cellSingleton()
    var cells = [slideBarItemCell]()
}

class hourScoreObject {
    var hour: Double
    var score: Double
    
    init(hour: Double, score: Double) {
        self.hour = hour
        self.score = score
    }
}
