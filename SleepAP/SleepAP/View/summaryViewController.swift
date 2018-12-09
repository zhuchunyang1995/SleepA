//
//  summaryViewController.swift
//  SleepAP
//
//  Created by Chunyang Zhu on 10/28/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Charts
import Parse

private let summaryLabelColor : UIColor = .black

class summaryViewController: recordSummaryParentViewController {

    @IBOutlet weak var weeksLineChartView: LineChartView!
    @IBOutlet weak var daysLineChartView: LineChartView!
    @IBOutlet weak var weeksButton: UIButton!
    @IBOutlet weak var daysButton: UIButton!
    @IBOutlet weak var targetSleepLabel: UILabel!
    @IBOutlet weak var sleepTimeLabel: UILabel!
    @IBOutlet weak var sleepDurationContent: UILabel!
    @IBOutlet weak var sleepTimeContent: UILabel!
    @IBOutlet weak var sleepDurationLabel: UILabel!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()
        let dayHours =  user!["last7SleepHour"] as! [Double]
        let weekHours =  user!["weeklyHour"] as! [Double]
        let dayScores = user!["last7AverageScore"] as! [Double]
        let weekScores = user!["weeklyScore"] as! [Double]
        
        setDaysChart(sleepHourDay: dayHours, sleepScoreDay: dayScores)
        setWeeksChart(sleepHourWeek: weekHours, sleepScoreWeek: weekScores)
        daysLineChartView.isHidden = false
        weeksLineChartView.isHidden = true
        setUpPieChart()
        
        let recommendSleepHour = calcBestHour(dayHours, dayScores, weekHours, weekScores)
        sleepDurationContent.text = "8 Hours"
//        let recommendSleepTime = calcBestSleepTime(dayHours, dayScores, weekHours, weekScores)
//        sleepTimeContent.text = String(recommendSleepTime)
        
        let (underDays, totalDays) = findUnderDays(dayHours, recommendSleepHour)
        let sleepDaysWithinOneHourOfTargetedTime = underDays
        let sleepTotalDays = totalDays
        
        daysButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)
        weeksButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)
        targetSleepLabel.text = "During \(sleepDaysWithinOneHourOfTargetedTime) out of the past \(sleepTotalDays) days, you have slept within one hour of your targeted sleep time."
        targetSleepLabel.font = UIFont(name: labelFontName, size: 15)
        recommendationLabel.font = UIFont(name: labelFontNameBold, size: 20)
        sleepTimeLabel.font = UIFont(name: labelFontName, size: 15)
        sleepTimeContent.font = UIFont(name: labelFontName, size: 15)
        sleepDurationLabel.font = UIFont(name: labelFontName, size: 15)
        sleepDurationContent.font = UIFont(name: labelFontName, size: 15)
    }
    
    func calcBestHour(_ dayHours: [Double], _ dayScores: [Double],_ weekHours: [Double], _ weekScores: [Double]) -> Int {
        var totalScore = 0.0
        var bestHour = 0.0
        var usefulPoints:[(hour: Double, score: Double)] = []
        for i in 0..<dayHours.count {
            if ((dayHours[i] != 0.0) || (dayScores[i] != 0.0)) {
                usefulPoints += [(hour: dayHours[i], score: dayScores[i])]
                totalScore += dayScores[i]
            }
        }
        for i in 0..<weekHours.count {
            if ((weekHours[i] != 0.0) || (weekScores[i] != 0.0)) {
                usefulPoints += [(hour: weekHours[i], score: weekScores[i])]
                totalScore += weekScores[i]
            }
        }
        for i in 0..<usefulPoints.count {
            bestHour += usefulPoints[i].0 * (usefulPoints[i].1/totalScore)
        }
        return Int(bestHour)
    }
    
    func findUnderDays(_ dayHours: [Double], _ recommendSleepHour: Int) -> (Int, Int) {
        var underDays = 0
        var totalDays = 0
        for i in 0..<dayHours.count {
            if (dayHours[i] != 0.0) {
                totalDays += 1
                if (dayHours[i] < Double(recommendSleepHour)) {
                    underDays += 1
                }
            }
        }
        return (underDays, totalDays)
    }
    
    func setUpPieChart() {
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = false
        pieChartView.isUserInteractionEnabled = false
        pieChartView.holeColor = UIColor.clear
        pieChartView.drawEntryLabelsEnabled = false
        
        pieChartView.chartDescription?.textAlign = NSTextAlignment.center
        pieChartView.legend.font = UIFont(name: labelFontName, size: 12)!
        pieChartView.legend.xOffset = pieChartView.bounds.minX + 30
        //pieChartView.legend.yOffset = pieChartView.bounds.maxY + 10

        let color1 = NSUIColor(red: 234/255.0, green: 112/255.0, blue: 46/255.0, alpha: 1.0)
        let color2 = NSUIColor(red: 131.0/255.0, green: 221.0/255.0, blue: 206.0/255.0, alpha: 1.0)

        var entries : [PieChartDataEntry] = []
        entries.append(PieChartDataEntry(value: 28.5, label: "Sleep before 12pm"))
        entries.append(PieChartDataEntry(value: 71.5, label: "Sleep after 12pm"))

        let dataSet = PieChartDataSet(values: entries, label: "")

        dataSet.colors = [color1, color2]
        dataSet.drawValuesEnabled = false
        
        pieChartView.data = PieChartData(dataSet: dataSet)
    }

    func setDaysChart(sleepHourDay: [Double], sleepScoreDay: [Double]){
        lineChartSetupHelper(lineChartType: daysLineChartView, xValues: sleepHourDay, yValues: sleepScoreDay)
    }
    
    func setWeeksChart(sleepHourWeek:[Double],sleepScoreWeek:[Double]){
        lineChartSetupHelper(lineChartType: weeksLineChartView, xValues: sleepHourWeek, yValues: sleepScoreWeek)
    }
    
    @IBAction func daysButton(_ sender: UIButton) {
        daysLineChartView.isHidden = false
        weeksLineChartView.isHidden = true
    }
    
    @IBAction func weeksButton(_ sender: UIButton) {
        daysLineChartView.isHidden = true
        weeksLineChartView.isHidden = false
    }
    
    func lineChartSetupHelper(lineChartType: LineChartView, xValues: [Double], yValues: [Double]) {
        lineChartType.chartDescription?.text = "Hours"
        lineChartType.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        lineChartType.leftAxis.axisMinimum = 0
        lineChartType.leftAxis.axisMaximum = 10
        lineChartType.rightAxis.enabled = false
        
        lineChartType.xAxis.axisMinimum = 5
        lineChartType.xAxis.axisMaximum = 10
        lineChartType.xAxis.labelCount = 5
        
        lineChartType.drawGridBackgroundEnabled = false
        lineChartType.leftAxis.drawAxisLineEnabled = true
        lineChartType.leftAxis.drawGridLinesEnabled = true
        lineChartType.xAxis.drawAxisLineEnabled = true
        lineChartType.xAxis.drawGridLinesEnabled = true
        lineChartType.borderColor = .gray
        lineChartType.drawBordersEnabled = true
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<xValues.count {
            if ((xValues[i] != 0.0) || (yValues[i] != 0.0)) {
                let dataEntry = ChartDataEntry(x: xValues[i], y: yValues[i])
                dataEntries.append(dataEntry)
            }
        }
        
        let daySleepDataSet = LineChartDataSet(values:dataEntries, label:"Scores")
        daySleepDataSet.highlightEnabled = false
        daySleepDataSet.drawCirclesEnabled = true
        daySleepDataSet.circleRadius = 5
        daySleepDataSet.drawValuesEnabled = false
        daySleepDataSet.drawFilledEnabled = true
        let data = LineChartData(dataSet: daySleepDataSet)
        lineChartType.data = data
    }
}
