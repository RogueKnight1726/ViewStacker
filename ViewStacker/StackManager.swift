//
//  StackManager.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


public class StackManager: UIView{
    
    var edgeSwipeGesture: UIScreenEdgePanGestureRecognizer!
    var arrayOfViews: [StackViewDimensionProtocol]!
    var currentScene = 0
    var guide: UILayoutGuide!
    
    func initiateGestureRecogniser(){
        edgeSwipeGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgeSwipeDetected(sender:)))
        edgeSwipeGesture.edges = .right
        
    }
    
    func addDismissGestureToAllViews(){
        arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    @objc func edgeSwipeDetected(sender: UIPanGestureRecognizer){
        print("Recieving Gesture")
        var dismissable = false
        if sender.translation(in: sender.view).x < -100 {
            dismissable = true
        }
        if sender.state == .ended{
            if dismissable{
                arrayOfViews[currentScene].state = .Dismissed
            }
        }
    }
}

protocol StackViewDimensionProtocol: UIView{
    var state: ViewState { get set }
    func heightOfHeaderView() -> CGFloat
//    func heightOfView() -> CGFloat
}


protocol StackNavigationProtocol: AnyObject{
    
    func moveForward(with dataSet: Any?)
    func dismissCurrentView()
}

enum ViewState{
    case Dismissed
    case Visible
    case FullScreen
}



extension StackManager: StackNavigationProtocol{
    func moveForward(with dataSet: Any?) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            var heightOffest: CGFloat = 0
            for i in 0...self!.currentScene{
                heightOffest = heightOffest + self!.arrayOfViews[i].heightOfHeaderView()
            }
            print("height offset : \(heightOffest)")
            self!.arrayOfViews[self!.currentScene + 1].transform = CGAffineTransform.init(translationX: 0, y: -(self!.guide.layoutFrame.height - heightOffest))
        }, completion: nil)
        if currentScene <= arrayOfViews.count{
            currentScene += 1
            arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
        }
    }
    
    func dismissCurrentView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            self!.arrayOfViews[self!.currentScene].transform  = .identity
        }, completion: nil)
        
        if currentScene > 0{
            currentScene -= 1
            arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
        } else{
            arrayOfViews[currentScene].removeFromSuperview()
        }
    }
    
    
}
