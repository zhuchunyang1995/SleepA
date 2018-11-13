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


class summaryViewController: UIViewController {

    @IBOutlet weak var recommendtext: UILabel!
    
    @IBOutlet weak var recomend: UILabel!
    
    let list = ["Your Score", "recommend "]
    
    @IBOutlet weak var weeksLineCharView: LineChartView!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    // connect to the database to get the weekly data
    let Hours = [1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0]
    let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]
    
    // Based on average week points calculation
    var weeklyHours = [1.0]
    var weeklyPoints = [1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Summary"
        

        // Get data from backend
        var query = PFQuery(className:"SleepHour")
        query.whereKey("objectID", equalTo:"MDelt7QayZ")
        query.findObjectsInBackground {
            (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    print(objects[0])
                }
            } else {
                // Log details of the failure
                print("failed")
            }
        }
        let user = PFUser.current()
        
        print(user)
        let Days = ["1","2","3","4","5","6","7","8","9","10"]
        let Points = [4.0, 4.0, 6.0, 3.0, 7.0, 6.0,5.0,7.0,4.0,9.0]
        
        setChart(dataPoints: Days, values: Points)

    }
    
    
    func setLabel(){
        var pos = 0;
        //find the maxium point of in current week
        if (Hours.isEmpty){

            recomend.text! = "Recommendations"
            recommendtext.text! = "Sleep time: " + "8.0"  + "  hours"
        }
        else{
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
        lineChartView.chartDescription?.text = "Hours"
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom;
        
        // Set the Range
        lineChartView.xAxis.axisMaximum = 12.0
        lineChartView.leftAxis.axisMaximum = 10.0
        lineChartView.xAxis.axisMinimum = 0
        lineChartView.leftAxis.axisMinimum = 0
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
        weeksLineCharView.chartDescription?.text = "Hours"
        weeksLineCharView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        weeksLineCharView.isHidden = true
        
        weeksLineCharView.xAxis.axisMaximum = 12.0
        weeksLineCharView.leftAxis.axisMaximum = 10.0
        weeksLineCharView.xAxis.axisMinimum = 0
        weeksLineCharView.leftAxis.axisMinimum = 0
        
        
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
