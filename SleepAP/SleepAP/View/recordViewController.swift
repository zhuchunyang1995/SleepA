//
//  recordViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 10/20/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit

private let leftRightMargin : CGFloat = 20.0
private let labelTopMargin: CGFloat = 10.0
private let slideBarBottomMargin: CGFloat = 20.0
private let thumbImageSize: CGFloat = 40.0
private let labelColor : UIColor = UIColor(red:0.96, green:0.93, blue:0.55, alpha:1.0)
private let tableViewBackgroundColor : UIColor = UIColor(red:0.21, green:0.22, blue:0.27, alpha:1.0)
private let cellBackgroundColor : UIColor = .clear

class slideBarItemCell: UITableViewCell {
    
    @IBOutlet weak var slideBarItemName: UILabel!
    @IBOutlet weak var slideBarPercentNumber: UILabel!
    @IBOutlet weak var slideBar: customSlider!
    
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
        
        slideBar.value = 0.5
        slideBar.tintColor = UIColor(red:0.96, green:0.93, blue:0.55, alpha:1.0)
        let slideWidth = self.contentView.frame.width - 2 * leftRightMargin
        slideBar.frame = CGRect(x: leftRightMargin, y: self.contentView.frame.height - slideBarBottomMargin - slideBarHeight, width: slideWidth, height: slideBarHeight)
    }
}

class numberInputItemCell: UITableViewCell {
    
    @IBOutlet weak var numberInputItemName: UILabel!
    @IBOutlet weak var numberInputText: UITextField!
    
    var itemString: String = ""  {
        didSet {
            numberInputItemName.text = itemString
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberInputItemName.textColor = labelColor
        numberInputItemName.font = UIFont(name: "Chalkduster", size: 22)
        numberInputItemName.textAlignment = .left
        let nameSize = numberInputItemName.intrinsicContentSize
        numberInputItemName.frame = CGRect(x: leftRightMargin, y: labelTopMargin, width: nameSize.width, height: nameSize.height)
    }
}

class recordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = recordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = tableViewBackgroundColor
        tableView.rowHeight = 100
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.recordItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recordItems[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.recordItems[indexPath.section]
        switch item.type {
        case .slideBar:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "slideBarItemCell", for: indexPath) as? slideBarItemCell {
                    cell.item = viewModel.slideBar[indexPath.row]
                    cell.layoutMargins = UIEdgeInsets.zero
                    cell.backgroundColor = cellBackgroundColor
                    return cell
                }
        case .numberInput:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "numberInputItemCell", for: indexPath) as? numberInputItemCell {
                    cell.itemString = viewModel.nameInputItems[indexPath.row]
                    cell.layoutMargins = UIEdgeInsets.zero
                    cell.backgroundColor = cellBackgroundColor
                }
        }
        
        return UITableViewCell()
    }
}
