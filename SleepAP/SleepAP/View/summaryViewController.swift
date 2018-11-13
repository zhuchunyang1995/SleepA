//
//  summaryViewController.swift
//  SleepAP
//
//  Created by Chunyang Zhu on 10/28/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Charts


class summaryViewController: UIViewController {

    @IBOutlet weak var recommendtext: UILabel!
    
    @IBOutlet weak var recomend: UILabel!
    
    let list = ["Your Score", "recommend "]
    
    @IBOutlet weak var weeksLineCharView: LineChartView!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    let Hours = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0]
    let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Summary"
        
        // connect to the database to get the weekly data

        setChart(dataPoints: Hours, values: Points)
        setWeeksChar(dataPoints: Hours, values: Points)
        setLabel()
    }
    func setLabel(){
        var pos = 0;
        
        //find the maxium point of weeks
        let points = lineChartView.leftAxis.axisMaximum;
        for (index, element) in Points.enumerated(){
            if element - points < 0.001{
                pos = index
            }
        }
        
        let str = String(Hours[pos]);
        recomend.text! = "Recommendations"
        recommendtext.text! = "Sleep time: " + str + "  hours"
    }

    func setChart(dataPoints: [Double], values: [Double]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        let line1 = LineChartDataSet(values:dataEntries,label:"Points")
        
        let data = LineChartData()
        data.addDataSet(line1)
        lineChartView.data = data;
        lineChartView.chartDescription?.text = "Days"
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom;
//        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Points","  /Sleeping Hours"])
    }
    func setWeeksChar(dataPoints:[Double],values:[Double]){
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
        lineChartView.isHidden = false;
        weeksLineCharView.isHidden = true;
        
    }
    
    @IBAction func weeksButton(_ sender: UIButton) {
        lineChartView.isHidden = true;
        weeksLineCharView.isHidden = false;
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
