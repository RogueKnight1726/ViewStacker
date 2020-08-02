//
//  EMIModel.swift
//  ViewStacker
//
//  Created by Next on 02/08/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


class EMIModel{
    
    var amountToBePaid: Int?
    var duration: Int?
    var selected: Bool?
    
    convenience init(amountToBePaid: Int?,duration: Int?,selected: Bool?) {
        self.init()
        self.amountToBePaid = amountToBePaid
        self.duration = duration
        self.selected = selected
    }
}
