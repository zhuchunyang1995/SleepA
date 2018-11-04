//
//  summaryViewController.swift
//  SleepAP
//
//  Created by Chunyang Zhu on 10/28/18.
//  Copyright © 2018 Wu, Tianyuan. All rights reserved.
//

import UIKit
import Charts


class summaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell()
        myCell.textLabel?.text = "Points"
        myCell.detailTextLabel?.text = "8.0"
        return myCell
    }
    
    
    let list = ["Your Score", "recommend "]
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Summary"
        
        let Days = ["Mon","Tue","Wed","Thr","Fri","Sat","Sun"]
        let Points = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0,17.0]
        
        setChart(dataPoints: Days, values: Points)
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
        lineChartView.chartDescription?.text = "Summary"
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
