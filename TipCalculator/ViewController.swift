//
//  ViewController.swift
//  TipCalculator
//
//  Created by QD on 12/18/17.
//  Copyright © 2017 Qingdong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipText: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
       
        billField.becomeFirstResponder()
        let defaults = UserDefaults.standard
        let defaultTipSelection = defaults.integer(forKey: "defaultTipSelection")
        tipControl.selectedSegmentIndex = defaultTipSelection
        if !defaults.bool(forKey: "emptyBill") {
            if let date = defaults.object(forKey: "creatBillTime") as? Date {
                if let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute, diff < 10 {
                    if defaults.bool(forKey: "isInteger") {
                        billField.text = "\(defaults.integer(forKey: "billInteger"))"
                    } else {
                        billField.text = "\(defaults.double(forKey: "billAmount"))"
                    }
                }
            }
            calculate()
        }
        setTheme()
    }
    
    func setTheme() {
        if defaults.integer(forKey: "themeSelection") == 1 {
            self.view.backgroundColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.8)
            self.billField.backgroundColor = UIColor(red:0/255, green:0/255, blue:0/255, alpha:0.8)
            self.tipLabel.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.9)
            self.tipText.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.9)
            self.billField.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.9)
        } else {
            self.view.backgroundColor = UIColor(red:92/255, green:201/255, blue:245/255, alpha:1)
            self.billField.backgroundColor = UIColor(red:92/255, green:201/255, blue:245/255, alpha:1)
        }
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

    @IBAction func saveBill(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(Date(), forKey:"creatBillTime")
        //print("\(billField.text!)")
        let isInteger = billField.text!.range(of: ".")
        
        if billField.text!.isEmpty {
            defaults.set(true, forKey:"emptyBill")
        } else {
            defaults.set(false, forKey:"emptyBill")
            if  isInteger == nil {
                defaults.set(true, forKey:"isInteger")
                let bill = Int(billField.text!) ?? 0
                //print("\(bill)")
                defaults.set(bill, forKey:"billInteger")
            } else {
                let bill = Double(billField.text!) ?? 0
                defaults.set(false, forKey:"isInteger")
                defaults.set(bill, forKey:"billAmount")
            }
        }
        defaults.synchronize()
    }
    
    func calculate() {
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

