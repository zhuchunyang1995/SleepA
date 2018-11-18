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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Summary"
        
        let user = PFUser.current()
        let dayHours =  user!["last7SleepHour"] as! [Double]
        let weekHours =  user!["weeklyHour"] as! [Double]
        let dayScores = user!["last7AverageScore"] as! [Double]
        let weekScores = user!["weeklyScore"] as! [Double]
        
        setChart(dataPoints: dayHours, values: dayScores)
        setWeeksChart(dataPoints: weekHours, values: weekScores)
        
        let recommendSleepHour = calcBestHour(dayHours, dayScores, weekHours, weekScores)
        sleepDurationContent.text = String(recommendSleepHour) + " Hours"
        
        let (underDays, totalDays) = findUnderDays(dayHours, recommendSleepHour)
        let sleepDaysWithinOneHourOfTargetedTime = underDays
        let sleepTotalDays = totalDays
        
        daysButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)
        weeksButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)
        targetSleepLabel.text = "During \(sleepDaysWithinOneHourOfTargetedTime) out of the past \(sleepTotalDays) days, you have slept within one hour of your targeted sleep time."
        targetSleepLabel.font = UIFont(name: labelFontName, size: 20)
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
    
//    func setUpPieChart() {
//        pieChartView.chartDescription?.enabled = false
//        pieChartView.drawHoleEnabled = false
//        pieChartView.rotationAngle = 0
//        pieChartView.rotationEnabled = false
//        pieChartView.isUserInteractionEnabled = false
//
//        let color1 = NSUIColor(hex: 0x000000)
//        let color2 = NSUIColor(hex: 0xFFFFFF)
//
//        var entries : [PieChartDataEntry] = []
//        entries.append(PieChartDataEntry(value: 50.0, label: "Sleep1"))
//        entries.append(PieChartDataEntry(value: 50.0, label: "Sleep2"))
//
//        let dataSet = PieChartDataSet(values: entries, label: "")
//
//        dataSet.colors = [color1, color2]
//        dataSet.drawValuesEnabled = false
//
//        pieChartView.data = PieChartData(dataSet: dataSet)
//    }
    
//    func setChart(dataPoints: [String], values: [Double]){
//        setChart(dataPoints: Hours, values: Points)
//        setWeeksChart(dataPoints: Hours, values: Points)
//        setLabel()
//    }
    
    
//    func setLabel(){
//        var pos = 0;
//        //find the maxium point of in current week
//        if (Hours.isEmpty){
//
////            recomend.text! = "Recommendations"
////            recommendtext.text! = "Sleep time: " + "8.0"  + "  hours"
//        }
//        else{
//            let points = daysLineChartView.leftAxis.axisMaximum;
//            for (index, element) in Points.enumerated(){
//                if element - points < 0.001{
//                    pos = index
//                }
//            }
//            let str = String(Hours[pos]);
////            recomend.text! = "Recommendations"
////            recommendtext.text! = "Sleep time: " + str + "  hours"
//        }
//    }

    func setChart(dataPoints: [Double], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            if ((dataPoints[i] != 0.0) || (values[i] != 0.0)) {
                let dataEntry = ChartDataEntry(x: dataPoints[i], y: values[i])
                dataEntries.append(dataEntry)
            }
            
        }
        
        let line1 = LineChartDataSet(values:dataEntries,label:"Scores")
        
        let data = LineChartData()
        data.addDataSet(line1)
        daysLineChartView.data = data;
        daysLineChartView.chartDescription?.text = "Days"
        daysLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom;
//        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Points","  /Sleeping Hours"])
    }
    
    func setWeeksChart(dataPoints:[Double],values:[Double]){
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            if ((dataPoints[i] != 0.0) || (values[i] != 0.0)) {
                let dataEntry = ChartDataEntry(x: dataPoints[i], y: values[i])
                dataEntries.append(dataEntry)
            }
        }
        let line1 = LineChartDataSet(values:dataEntries,label:"Scores")
        let data = LineChartData()
        data.addDataSet(line1)
        weeksLineChartView.data = data
        weeksLineChartView.chartDescription?.text = "Weeks"
        weeksLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        weeksLineChartView.isHidden = true
        
//        weeksLineChartView.xAxis.axisMaximum = 15.0
//        weeksLineChartView.leftAxis.axisMaximum = 1.0
//        weeksLineChartView.xAxis.axisMinimum = 0
//        weeksLineChartView.leftAxis.axisMinimum = 0
    }
    
    @IBAction func daysButton(_ sender: UIButton) {
        daysLineChartView.isHidden = false
        weeksLineChartView.isHidden = true
        
    }
    
    @IBAction func weeksButton(_ sender: UIButton) {
        daysLineChartView.isHidden = true
        weeksLineChartView.isHidden = false
    }
}
