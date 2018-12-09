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
private let thumbImageSize: CGFloat = 35.0
private let slideBarlabelColor : UIColor = .black
private let slideBarMinTrackColor : UIColor = UIColor(red:0.69, green:0.89, blue:0.86, alpha:1.0)
private let slideBarMaxTrackColor : UIColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0)
private let tableViewBackgroundColor : UIColor = UIColor(red:0.21, green:0.20, blue:0.48, alpha:1.0)
private let cellBackgroundColor : UIColor = .clear

class slideBarItemCell: UITableViewCell {
    
    @IBOutlet weak var slideBarItemName: UILabel!
    @IBOutlet weak var slideBarPercentNumber: UILabel!
    @IBOutlet weak var slideBar: customSlider!
    var slideDoubleNumber : Double = 0.0

    @IBAction func valueChanged(_ sender: customSlider) {
        slideBar.value = roundf(sender.value)
        slideBarPercentNumber.text = item?.levels[Int(roundf(sender.value))]
        slideDoubleNumber = Double(roundf(sender.value))
    }
    
    var item: slideBarItem?  {
        didSet {
            slideBarItemName.text = item?.slideBarItemName
            var image = UIImage(named: (item?.slideBarItemImageName)!)
            image = UIImage.scaleImageToSize(image: image!, size: CGSize(width: thumbImageSize, height: thumbImageSize))
            slideBar.setThumbImage(image, for: .normal)
            slideBar.setThumbImage(image, for: .highlighted)
            slideBarPercentNumber.text = item?.levels[0]
            setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        slideBar.maximumValue = 3
        slideBar.minimumValue = 0
        slideBar.isContinuous = false
        slideBar.value = 0.0
        slideBar.isContinuous = true
        slideBar.minimumTrackTintColor = slideBarMinTrackColor
        slideBar.maximumTrackTintColor = slideBarMaxTrackColor
        let slideWidth = self.contentView.frame.width - 2 * leftRightMargin
        slideBar.frame = CGRect(x: leftRightMargin, y: self.contentView.frame.height - slideBarBottomMargin - slideBarHeight, width: slideWidth, height: slideBarHeight)
        
        slideBarItemName.textColor = slideBarlabelColor
        slideBarItemName.font = UIFont(name: labelFontName, size: 22)
        slideBarItemName.textAlignment = .left
        let nameSize = slideBarItemName.intrinsicContentSize
        slideBarItemName.frame = CGRect(x: leftRightMargin, y: labelTopMargin, width: nameSize.width, height: nameSize.height)
        
        slideBarPercentNumber.textColor = slideBarlabelColor
        slideBarPercentNumber.font = UIFont(name: "FiraSansCondensed-UltraLight", size: 18)
        slideBarPercentNumber.textAlignment = .right
        slideBarPercentNumber.numberOfLines = 0
        let percentSize = slideBarPercentNumber.intrinsicContentSize
        let startXPos = slideBarItemName.bounds.maxX + 30
        slideBarPercentNumber.frame = CGRect(x: startXPos, y: labelTopMargin + 2, width: slideBar.bounds.maxX - startXPos, height: percentSize.height)
    }
}

class recordViewController: recordSummaryParentViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    let viewModel = recordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = tableViewBackgroundColor
        tableView.rowHeight = tableViewCellHeight
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
        submitButton.setTitleColor(slideBarlabelColor, for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "District", size: 50)
        submitButton.titleLabel?.textAlignment = .center
        let buttonSize = submitButton.intrinsicContentSize
        submitButton.frame = CGRect(x: self.view.bounds.width / 2 - buttonSize.width / 2, y: tableView.bounds.height + 20, width: buttonSize.width, height: buttonSize.height)
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
        saveScoreToBackend()
    }

    // helper functions
    func saveScoreToBackend() {
        // Float number: 0.0, 1.0, 2.0, 3.0. rescale to 10 point scale.
        let sleepQualityScore = cellSingleton.sharedInstance.cells[0].slideDoubleNumber * 3.33
        let health = cellSingleton.sharedInstance.cells[1].slideDoubleNumber * 3.33
        let productivity = cellSingleton.sharedInstance.cells[2].slideDoubleNumber * 3.33
        let energy = cellSingleton.sharedInstance.cells[3].slideDoubleNumber * 3.33
        let mood = cellSingleton.sharedInstance.cells[4].slideDoubleNumber * 3.33
        
        let denominator = (Double((sleepQualityScore != 0) as NSNumber) + Double((health != 0) as NSNumber) + Double((productivity != 0) as NSNumber) + Double((energy != 0) as NSNumber) + Double((mood != 0)as NSNumber))
        let divisor = denominator != 0.0 ? 1 / denominator : 0.0
        let averageScore = (sleepQualityScore + health + productivity + energy + mood) * divisor
        
        // store score
        let user = PFUser.current()
        var scoreList = user?["last7AverageScore"] as! [Double]
        scoreList.append(averageScore)
        user?["last7AverageScore"] = scoreList
        
        // store hour
        var hourList = user?["last7SleepHour"] as! [Double]
        hourList.append(getSleepDuration())
        user?["last7SleepHour"] = hourList

        user?.saveInBackground {
            (success, error) in
            if (success) {
                let alert = UIAlertController(title: "Successful", message: "Your summary has been submitted",  preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
            }
        }
    }
}
