//
//  ThirdView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class ThirdView: SwipableBaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    
    override var state: ViewState!{
        didSet{
            navigationDelegate?.dismissCurrentView()
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
    
    
    
    func heightOfHeaderView() -> CGFloat {
        return 50
    }
    
    
    
}
