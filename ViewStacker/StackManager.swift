//
//  StackManager.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


public class StackManager{
    
    var arrayOfViews: [StackViewDimensionProtocol]?
}

protocol StackViewDimensionProtocol: UIView{
    func heightOfHeaderView() -> CGFloat
//    func heightOfView() -> CGFloat
}


protocol StackNavigationProtocol: AnyObject{
    
    func moveForward(with dataSet: Any?)
    func dismissCurrentView()
}
