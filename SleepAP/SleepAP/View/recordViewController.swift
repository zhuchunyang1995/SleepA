//
//  recordViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/20/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Parse

private let leftRightMargin : CGFloat = 20.0
private let labelTopMargin: CGFloat = 10.0
private let tableViewCellHeight : CGFloat = 100.0
private let slideBarBottomMargin: CGFloat = 20.0
private let thumbImageSize: CGFloat = 40.0
private let labelColor : UIColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0)
private let slideBarColor : UIColor = UIColor(red:0.96, green:0.93, blue:0.55, alpha:1.0)
private let tableViewBackgroundColor : UIColor = UIColor(red:0.21, green:0.20, blue:0.48, alpha:1.0)
private let cellBackgroundColor : UIColor = .clear

class slideBarItemCell: UITableViewCell {
    
    @IBOutlet weak var slideBarItemName: UILabel!
    @IBOutlet weak var slideBarPercentNumber: UILabel!
    @IBOutlet weak var slideBar: customSlider!

    @IBAction func valueChanged(_ sender: customSlider) {
        slideBarPercentNumber.text = String(Int(sender.value * 100)) + "%"
    }
    
    var item: slideBarItem?  {
        didSet {
            slideBarItemName.text = item?.slideBarItemName
            var image = UIImage(named: (item?.slideBarItemImageName)!)
            image = UIImage.scaleImageToSize(image: image!, size: CGSize(width: thumbImageSize, height: thumbImageSize))
            slideBar.setThumbImage(image, for: .normal)
            slideBar.setThumbImage(image, for: .highlighted)
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        slideBarItemName.textColor = labelColor
        slideBarItemName.font = UIFont(name: "Chalkduster", size: 22)
        slideBarItemName.textAlignment = .left
        let nameSize = slideBarItemName.intrinsicContentSize
        slideBarItemName.frame = CGRect(x: leftRightMargin, y: labelTopMargin, width: nameSize.width, height: nameSize.height)
        
        slideBarPercentNumber.textColor = labelColor
        slideBarPercentNumber.font = UIFont(name: "Chalkduster", size: 22)
        slideBarPercentNumber.textAlignment = .left
        let percentSize = slideBarPercentNumber.intrinsicContentSize
        slideBarPercentNumber.frame = CGRect(x: self.contentView.frame.width - leftRightMargin - percentSize.width, y: labelTopMargin, width: percentSize.width, height: percentSize.height)
        slideBarPercentNumber.text = "0%"
        
        slideBar.value = 0.0
        slideBar.isContinuous = true
        slideBar.tintColor = slideBarColor
        let slideWidth = self.contentView.frame.width - 2 * leftRightMargin
        slideBar.frame = CGRect(x: leftRightMargin, y: self.contentView.frame.height - slideBarBottomMargin - slideBarHeight, width: slideWidth, height: slideBarHeight)
    }
}

class recordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    let viewModel = recordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = tableViewBackgroundColor
        tableView.rowHeight = tableViewCellHeight
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        submitButton.setTitleColor(labelColor, for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 22)
        submitButton.titleLabel?.textAlignment = .center
        let buttonSize = submitButton.intrinsicContentSize
        submitButton.frame = CGRect(x: self.view.bounds.width / 2 - buttonSize.width / 2, y: tableView.bounds.height + 50, width: buttonSize.width, height: buttonSize.height)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.recordItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recordItems[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "slideBarItemCell", for: indexPath) as? slideBarItemCell {
                cell.item = viewModel.slideBar[indexPath.row]
                cell.layoutMargins = UIEdgeInsets.zero
                cell.backgroundColor = cellBackgroundColor
                cell.selectionStyle = .none
                tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))

                return cell
            }
        
        return UITableViewCell()
    }
    
    
    @IBAction func submit(_ sender: UIButton) {
        if (cellSingleton.sharedInstance.cells.isEmpty) {
            for i in 0...4 {
                cellSingleton.sharedInstance.cells.append(
                    tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! slideBarItemCell)
            }
        }
        let sleepQualityScore = cellSingleton.sharedInstance.cells[0].slideBarPercentNumber.text!
        let health = cellSingleton.sharedInstance.cells[1].slideBarPercentNumber.text!
        let productivity = cellSingleton.sharedInstance.cells[2].slideBarPercentNumber.text!
        let energy = cellSingleton.sharedInstance.cells[3].slideBarPercentNumber.text!
        let mood = cellSingleton.sharedInstance.cells[4].slideBarPercentNumber.text!
        
        // Push the record to backend
        let doubleSleepQualityScore = Double(String(sleepQualityScore.dropLast()))! * 0.01
        let doubleHealthScore = Double(String(health.dropLast()))! * 0.01
        let doubleProductivityScore = Double(String(productivity.dropLast()))! * 0.01
        let doubleEnergyScore = Double(String(energy.dropLast()))! * 0.01
        let doubleMoodScore = Double(String(mood.dropLast()))! * 0.01
        let denominator = (Double((doubleSleepQualityScore != 0) as NSNumber) + Double((doubleHealthScore != 0) as NSNumber) + Double((doubleProductivityScore != 0) as NSNumber) + Double((doubleEnergyScore != 0) as NSNumber) + Double((doubleMoodScore != 0)as NSNumber))
        let diviosr = denominator != 0.0 ? 1 / denominator : 0.0
        let averageScore = (doubleSleepQualityScore+doubleHealthScore+doubleProductivityScore+doubleEnergyScore+doubleMoodScore) * diviosr
        
        let user = PFUser.current()
        
        
        let summary = PFObject(className:"Summary")
        summary["User"] = user
        summary["SleepQualityScore"] = doubleSleepQualityScore
        summary["HealthScore"] = doubleHealthScore
        summary["ProductivityScore"] = doubleProductivityScore
        summary["EnergyScore"] = doubleEnergyScore
        summary["MoodScore"] = doubleMoodScore
        summary["AverageScore"] = averageScore
        summary.saveInBackground {
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
