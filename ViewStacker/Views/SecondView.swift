//
//  SecondView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager


class SecondView: BaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    public var currentState: ViewState!{
        didSet{
            switch currentState {
            case .Dismissed:
                print("Second View is Dismissed")
                navigationDelegate?.dismissCurrentView()
                break
            case .Visible:
                print("Second View is Visible")
                navigationDelegate?.moveForward()
                break
            case .FullScreen:
                break
            default:
                break
            }
        }
    }
    
    
    
    //App related properties
    var headerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



extension SecondView: StackViewDimensionProtocol{
    func recieveIncomingData(value: Any?) {
    }
    
    func sendDataToNextView() -> Any? {
        return 80
    }
    
    var state: ViewState {
        get {
            return currentState
        }
        set {
            self.currentState = newValue
        }
    }
    
    
    func heightOfHeaderView() -> CGFloat {
        return 100
    }
    
    
    
}


extension SecondView{
    
    
    func initViews(){
        
        
        
    }
}
