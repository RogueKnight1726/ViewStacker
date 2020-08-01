//
//  ThirdView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager

class ThirdView: BaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    
    public var currentState: ViewState!{
        didSet{
            switch currentState {
            case .Dismissed:
                navigationDelegate?.dismissCurrentView()
                break
            case .Visible:
                navigationDelegate?.moveForward()
                break
            case .FullScreen:
                break
            default:
                break
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}



extension ThirdView: StackViewDimensionProtocol{
    func recieveIncomingData(value: Any?) {
    }
    
    func sendDataToNextView() -> Any? {
        return nil
    }
    
    
    var state: ViewState {
        get {
            return currentState
        }
        set {
            self.currentState = newValue
//            navigationDelegate?.dismissCurrentView()
        }
    }
    
    func heightOfHeaderView() -> CGFloat {
        return 50
    }
    
    
    
}
