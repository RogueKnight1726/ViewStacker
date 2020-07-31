//
//  SwipableBaseView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class SwipableBaseView: BaseView{
    
    var edgeSwipeGesture: UIScreenEdgePanGestureRecognizer!
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        
//        edgeSwipeGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgeSwipeDetected(sender:)))
//        edgeSwipeGesture.edges = .right
//        self.addGestureRecognizer(edgeSwipeGesture)
        
    }
    

    
//    @objc func edgeSwipeDetected(sender: UIPanGestureRecognizer){
//        print("Recieving Gesture")
//        var dismissable = false
//        if sender.translation(in: self).x < -100 {
//            dismissable = true
//        }
//        if sender.state == .ended{
//            if dismissable{
//                self.state = .Dismissed
//            }
//        }
//    }
}


