//
//  reminderTimeViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import UserNotifications
import Parse

private let reminderLabelColor : UIColor = .white

class reminderTimeViewController: reminderParentViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timePickerView: UIDatePicker!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var musicDescriptionTextLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var musicPickerView: UIPickerView!
    @IBOutlet weak var changeMusicButton: UIButton!
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var switchReminder: UISwitch!
    @IBOutlet weak var doneView: UIView!
    
    let musicList = ["Piano", "Guitar", "Violin", "Rock", "News"]
    var isSleepReminderOn : Bool = false
    var sleepReminderTimeString : String = "00:00 AM"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        doneView.layer.cornerRadius = 0.5 * doneView.bounds.width
        doneView.clipsToBounds = true
        
        // Get data from backend
        if let user = PFUser.current() {
            isSleepReminderOn = user["reminderOn"] as! Bool
            sleepReminderTimeString = user["reminderTime"] as! String
        }

        
        setUpTimeView()
        setUpMusicView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        musicPickerView.subviews[1].isHidden = true
        musicPickerView.subviews[2].isHidden = true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if (isSleepReminderOn) {
            sleepReminderTimeString = hourMiniteStringFrom(date: timePickerView.date)
            
            // first remove the previous notification, if one exists
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["sleepReminder"])

            // create a new notification
            let content = UNMutableNotificationContent()
            content.title = "Time to sleep!"
            content.body = "Early sleep makes you healthier and wiser. If you haven't finished your work today, get up early tomorrow to finish them! If you are playing games, well then..."
            content.sound = UNNotificationSound.default // TODO: change according to type
            
            let pickerDate = timePickerView.date
            let components = Calendar.current.dateComponents([.hour, .minute], from: pickerDate)
            let hour = components.hour!
            let minute = components.minute!
            
            var date = DateComponents()
            date.hour = hour
            date.minute = minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            let request = UNNotificationRequest(identifier: "sleepReminder", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        } else {
            sleepReminderTimeString = "00:00 AM"
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["sleepReminder"])
        }
        
        // Save Data to the backend
        if let user = PFUser.current() {
            user["reminderOn"] = isSleepReminderOn
            user["reminderTime"] = sleepReminderTimeString
            user.saveInBackground {
                (success, error) in
                if (success) {
                    let alert = UIAlertController(title: "Successed", message: "The reminder is on",  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{action in
                        // show main tab bar
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
                        self.present(vc, animated: false, completion: nil)
                    }))
                    
                    self.present(alert, animated: true)
                } else {
                    // There was a problem, check error.description
                    let alert = UIAlertController(title: "Failed", message: "Please try again",  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
        
    }
    
    
    
    // turn on/off the switch
    @IBAction func switchTapped(_ sender: UISwitch) {
        if (sender.isOn) {
            isSleepReminderOn = true
        }
        else {
            isSleepReminderOn = false
        }
    }
    
    // UIGestureRecognizerDelegate, view will respond to multiple gestures
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // music picker delegate & datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return musicList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return musicList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        musicLabel.text = musicList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = reminderLabelColor
        label.textAlignment = .center
        label.text = musicList[row]
        label.font = UIFont(name: labelFontNameBold, size: 22)
        return label
    }
    
    // time view related
    @IBAction func changeTime(_ sender: UIButton) {
        timePickerView.isHidden = false
        timeLabel.isHidden = true
        changeButton.isHidden = true
        textLabel.isHidden = true
        switchReminder.isHidden = true
    }
    
    @objc func dismissTimePicker(gestureRecognizer: UIGestureRecognizer) {
        timePickerView.isHidden = true
        timeLabel.isHidden = false
        changeButton.isHidden = false
        textLabel.isHidden = false
        switchReminder.isHidden = false
        timeLabel.text = hourMiniteStringFrom(date: timePickerView.date)
    }
    
    func setUpTimeView() {
        switchReminder.isOn = isSleepReminderOn
        switchReminder.transform = CGAffineTransform(scaleX: 0.55, y: 0.5)
        switchReminder.onTintColor = UIColor(red:1.00, green:0.91, blue:0.87, alpha:1.0)
        
        timePickerView.isHidden = true
        timePickerView.setValue(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), forKeyPath: "textColor")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: sleepReminderTimeString.components(separatedBy: " ")[0])
        timePickerView.date = date!
        timePickerView.subviews[0].subviews[1].isHidden = true
        timePickerView.subviews[0].subviews[2].isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTimePicker(gestureRecognizer:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        textLabel.textColor = reminderLabelColor
        textLabel.font = UIFont(name: labelFontNameBold, size: 14)
        textLabel.text = "REMIND ME TO SLEEP"
        
        timeLabel.textColor = reminderLabelColor
        timeLabel.font = UIFont(name: labelFontName, size: 40)
        timeLabel.text = sleepReminderTimeString
        
        changeButton.setTitleColor(reminderLabelColor, for: .normal)
        changeButton.titleLabel?.font = UIFont(name: labelFontName, size: 15);
        
        timeView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        timeView.layer.cornerRadius = 20
        timeView.clipsToBounds = true
    }
    
    // music view related
    @IBAction func changeMusic(_ sender: UIButton) {
        musicPickerView.isHidden = false
        musicLabel.isHidden = true
        changeMusicButton.isHidden = true
        musicDescriptionTextLabel.isHidden = true
    }
    
    @objc func dismissMusicPicker(gestureRecognizer: UIGestureRecognizer) {
        musicPickerView.isHidden = true
        musicLabel.isHidden = false
        changeMusicButton.isHidden = false
        musicDescriptionTextLabel.isHidden = false
    }
    
    func setUpMusicView() {
        musicPickerView.delegate = self
        musicPickerView.dataSource = self
        musicPickerView.isHidden = true
        musicPickerView.setValue(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), forKeyPath: "textColor")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMusicPicker(gestureRecognizer:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)

        musicDescriptionTextLabel.textColor = reminderLabelColor
        musicDescriptionTextLabel.font = UIFont(name: labelFontNameBold, size: 14)
        musicDescriptionTextLabel.text = "WITH MUSIC"

        musicLabel.textColor = reminderLabelColor
        musicLabel.font = UIFont(name: labelFontName, size: 40)
        musicLabel.text = "Piano"

        changeMusicButton.setTitleColor(reminderLabelColor, for: .normal)
        changeMusicButton.titleLabel?.font = UIFont(name: labelFontName, size: 15);

        musicView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        musicView.layer.cornerRadius = 20
        musicView.clipsToBounds = true
    }
    
    func hourMiniteStringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date)
    }
}
