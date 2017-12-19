//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by QD on 12/18/17.
//  Copyright © 2017 Qingdong. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var defaultTipSelection: UISegmentedControl!
    
    @IBOutlet weak var themeSelection: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let selection = defaults.integer(forKey: "defaultTipSelection")
        let theme = defaults.integer(forKey: "themeSelection")
        themeSelection.selectedSegmentIndex = theme
        defaultTipSelection.selectedSegmentIndex = selection
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func setTheme(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(themeSelection.selectedSegmentIndex, forKey: "themeSelection")
        defaults.synchronize()
    }
    
    
    
    @IBAction func setDefaultTipAmount(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(defaultTipSelection.selectedSegmentIndex, forKey: "defaultTipSelection")
       
        defaults.synchronize()
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
