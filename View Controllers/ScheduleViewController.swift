//
//  ScheduleViewController.swift
//  PickUp
//
//  Created by Anushrut Shah on 26/04/2019.
//  Copyright © 2019 Anushrut Shah. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var viewOnline: UILabel!
    @IBOutlet weak var schedule: UIImageView!
    var segment: Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func fullSchedule(_ sender: Any) {
        if (segment) {
            UIApplication.shared.open(URL(string: "https://pennathletics.com/documents/2019/4/16//DCC.pdf?id=16105")! as URL, options: [:], completionHandler: nil)
        } else {
          UIApplication.shared.open(URL(string: "https://pennathletics.com/documents/2019/4/16//Adams.pdf?id=16104")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            schedule.image = UIImage(named: "scheduleAce")
            
        } else {
            segment = true;
            schedule.image = UIImage(named: "scheduleDC")
        }
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
