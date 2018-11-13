//
//  reminderTimeViewController.swift
//  SleepAP
//
//  Created by Xiayi Sun on 11/11/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import UserNotifications

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
    var isNotificationOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTimeView()
        setUpMusicView()
        
        doneView.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.4)
        doneView.layer.cornerRadius = 0.5 * doneView.bounds.width
        doneView.clipsToBounds = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        musicPickerView.subviews[1].isHidden = true
        musicPickerView.subviews[2].isHidden = true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        if (isNotificationOn) {
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
            // TODO: TEST THIS
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                var identifiers: [String] = []
                for notification: UNNotificationRequest in notificationRequests {
                    if notification.identifier == "sleepReminder" {
                        identifiers.append(notification.identifier)
                    }
                }
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
            }
        }
        
        // show main tab bar
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarViewController") as UIViewController
        present(vc, animated: false, completion: nil)
    }
    
    // turn on/off the switch
    @IBAction func switchTapped(_ sender: UISwitch) {
        if (sender.isOn) {
            isNotificationOn = true
        }
        else {
            isNotificationOn = false
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
    
    @objc func timeChanged(timePickerView: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        timeLabel.text = dateFormatter.string(from: timePickerView.date)
    }
    
    @objc func dismissTimePicker(gestureRecognizer: UIGestureRecognizer) {
        timePickerView.isHidden = true
        timeLabel.isHidden = false
        changeButton.isHidden = false
        textLabel.isHidden = false
        switchReminder.isHidden = false
    }
    
    func setUpTimeView() {
        switchReminder.transform = CGAffineTransform(scaleX: 0.55, y: 0.5)
        switchReminder.onTintColor = UIColor(red:1.00, green:0.91, blue:0.87, alpha:1.0)
        
        timePickerView.isHidden = true
        timePickerView.addTarget(self, action: #selector(timeChanged(timePickerView:)), for: .valueChanged)
        timePickerView.setValue(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), forKeyPath: "textColor")
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
        timeLabel.text = "00:00 AM"
        
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
    
    @objc func musicChanged(musicPickerView: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        timeLabel.text = dateFormatter.string(from: timePickerView.date)
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
}