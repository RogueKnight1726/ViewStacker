//
//  SwipableBaseView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class SwipableBaseView: BaseView{
    
    var panGesture: UIScreenEdgePanGestureRecognizer!
    var state: ViewState!
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        panGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(panDetected(sender:)))
        panGesture.edges = .right
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func panDetected(sender: UIPanGestureRecognizer){
        print("Recieving Gesture")
        if sender.translation(in: self).x < -100 {
            self.state = .Dismissed
            sender.state = .ended
        }
    }
}


enum ViewState{
    case Dismissed
    case Visible
    case FullScreen
}
