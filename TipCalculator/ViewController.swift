//
//  ViewController.swift
//  TipCalculator
//
//  Created by QD on 12/18/17.
//  Copyright © 2017 Qingdong. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var tipText: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    
    func formatLocale(num:NSNumber) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
        return currencyFormatter.string(from: num)!
    }
    
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
        if billField.text!.isEmpty {
            hideView()
            showPlaceHolder()
        } else {
            self.tipControl.alpha = 1
            self.totalView.alpha = 1
            self.tipControl.frame.origin.y = self.billField.frame.origin.y + 110
            self.totalView.frame.origin.y = self.billField.frame.origin.y + 170
        }
    }
    
    func showPlaceHolder() {
        billField.placeholder = NSLocale.current.currencySymbol
    }
    
    func setTheme() {
        self.tipLabel.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.98)
        self.tipText.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.98)
        self.billField.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.98)
        self.totalLabel.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.98)
        self.totalText.textColor = UIColor(red:192/255, green:142/255, blue:14/255, alpha:0.98)
        self.totalView.backgroundColor = UIColor(red:20/255, green:20/255, blue:20/255, alpha:0.8)
        
        if defaults.integer(forKey: "themeSelection") == 1 {
            self.view.backgroundColor = UIColor(red:40/255, green:40/255, blue:40/255, alpha:1)
            self.billField.backgroundColor = UIColor(red:40/255, green:40/255, blue:40/255, alpha:1)
            
        } else {
            self.view.backgroundColor = UIColor(red:92/255, green:201/255, blue:245/255, alpha:1)
            self.billField.backgroundColor = UIColor(red:92/255, green:201/255, blue:245/255, alpha:1)
        }
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func hideView() {
        self.tipControl.frame.origin.y = self.billField.frame.origin.y + 100
        self.totalView.frame.origin.y = self.billField.frame.origin.y + 120
        self.tipControl.alpha = 0
        self.totalView.alpha = 0
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
        //view.endEditing(true)
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
        tipLabel.text = formatLocale(num: tip as NSNumber)
        totalLabel.text = formatLocale(num: total as NSNumber)
    }
    
    @IBAction func calculateTip(_ sender: Any?) {
        if billField.text!.isEmpty {
            showPlaceHolder()
            UIView.animate(withDuration:0.8, animations: {
                // This causes first view to fade in and second view to fade out
                self.tipControl.alpha = 0
                self.totalView.alpha = 0
                self.tipControl.frame.origin.y = self.billField.frame.origin.y + 200
                self.totalView.frame.origin.y = self.billField.frame.origin.y + 250
            })
        } else {
            self.tipControl.alpha = 1
            self.totalView.alpha = 1
            self.tipControl.frame.origin.y = self.billField.frame.origin.y + 110
            self.totalView.frame.origin.y = self.billField.frame.origin.y + 170
            
        }
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "billAmount")
        defaults.synchronize()
        
       // billAmount.text = currencyFormatter.string(from:1230.90)
        
        tipLabel.text = formatLocale(num: tip as NSNumber)
        totalLabel.text = formatLocale(num: total as NSNumber)
    }

}


