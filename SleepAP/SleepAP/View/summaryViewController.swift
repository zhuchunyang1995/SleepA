//
//  summaryViewController.swift
//  SleepAP
//
//  Created by Chunyang Zhu on 10/28/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Charts

private let summaryLabelColor : UIColor = .black

class summaryViewController: recordSummaryParentViewController {

    let list = ["Your Score", "recommend "]
    @IBOutlet weak var weeksLineCharView: LineChartView!
    @IBOutlet weak var daysLineChartView: LineChartView!
    @IBOutlet weak var daysButton: UIButton!
    @IBOutlet weak var weeksButton: UIButton!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Summary"
        
        let Days = ["1","2","3","4","5","6","7","8","9","10"]
        let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]
        
        setChart(dataPoints: Days, values: Points)
        setWeeksChar(dataPoints: Days, values: Points)
        setUpPieChart()
        daysButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)
        weeksButton.titleLabel?.font =  UIFont(name: labelFontName, size: 20)

    }
    
    func setUpPieChart() {
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = false
        pieChartView.isUserInteractionEnabled = false
        
        let color1 = NSUIColor(hex: 0x000000)
        let color2 = NSUIColor(hex: 0xFFFFFF)
        
        var entries : [PieChartDataEntry] = []
        entries.append(PieChartDataEntry(value: 50.0, label: "Sleep1"))
        entries.append(PieChartDataEntry(value: 50.0, label: "Sleep2"))
        
        let dataSet = PieChartDataSet(values: entries, label: "")
        
        dataSet.colors = [color1, color2]
        dataSet.drawValuesEnabled = false
        
        pieChartView.data = PieChartData(dataSet: dataSet)
    }
    
    func setChart(dataPoints: [String], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let line1 = LineChartDataSet(values:dataEntries,label:"Points")
        
        let data = LineChartData()
        data.addDataSet(line1)
        daysLineChartView.data = data;
        daysLineChartView.chartDescription?.text = "Days"
        daysLineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom;
//        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Points","  /Sleeping Hours"])
    }
    
    func setWeeksChar(dataPoints:[String],values:[Double]){
        var dataEntries:[ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        let line1 = LineChartDataSet(values:dataEntries,label:"Points")
        let data = LineChartData()
        data.addDataSet(line1)
        weeksLineCharView.data = data
        weeksLineCharView.chartDescription?.text = "Weeks"
        weeksLineCharView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        weeksLineCharView.isHidden = true
    }
    
    @IBAction func daysButton(_ sender: UIButton) {
        daysLineChartView.isHidden = false
        weeksLineCharView.isHidden = true
        
    }
    
    @IBAction func weeksButton(_ sender: UIButton) {
        daysLineChartView.isHidden = true
        weeksLineCharView.isHidden = false
    }
}
