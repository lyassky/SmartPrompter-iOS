//
//  ChecklistItem.swift
//  checklist
//
//  Created by Leah Yassky on 7/11/19.
//  Copyright © 2019 Leah Yassky. All rights reserved.
//

import Foundation


class ChecklistItem: NSObject {
    var text = "" // the label of the alarm
    var checked = false // whether or not it is displayed as checked or not in the main view
    var time = "" // the time of the alarm
    var status = false //the status of the alarm is defaulted to off
    
    func toggleChecked(){
        checked = !checked
    }
}
