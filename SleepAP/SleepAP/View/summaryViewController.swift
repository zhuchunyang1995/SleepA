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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Summary"
        
        let Days = ["1","2","3","4","5","6","7","8","9","10"]
        let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]
        
        setChart(dataPoints: Days, values: Points)
        setWeeksChar(dataPoints: Days, values: Points)
        setLabel()
    }
    func setLabel(){
        recomend.text! = "Recommendations"
        
        recommendtext.text! = "Sleep time:    8 hours"
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
        lineChartView.data = data;
        lineChartView.chartDescription?.text = "Days"
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom;
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
