//
//  ViewController.swift
//  TipCalculator
//
//  Created by QD on 12/18/17.
//  Copyright © 2017 Qingdong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor(red:92/255, green:201/255, blue:245/255, alpha:9)
        
        billField.becomeFirstResponder()
        let defaults = UserDefaults.standard
        let defaultTipSelection = defaults.integer(forKey: "defaultTipSelection")
        //let bill = defaults.double(forKey: "billAmount")
        //billField.text = "100"
        tipControl.selectedSegmentIndex = defaultTipSelection
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        let defaultTipSelection = defaults.integer(forKey: "defaultTipSelection")
        tipControl.selectedSegmentIndex = defaultTipSelection
    }
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    
    @IBAction func calculateTip(_ sender: Any?) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "billAmount")
        defaults.synchronize()
        tipLabel.text = String(format:"$%.2f",tip)
        totalLabel.text = String(format:"$%.2f", total)
    }
    
}

