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
    var arrayOfViews: [StackViewDimensionProtocol]!{
        didSet{
            initiateGestureRecogniser()
        }
    }
    var currentScene = 0
    var guide: UILayoutGuide!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect,viewStack: [StackViewDimensionProtocol],guide: UILayoutGuide) {
        self.init()
        self.frame = frame
        self.guide = guide
        self.arrayOfViews = viewStack
        initViews()
        initiateGestureRecogniser()
    }
    
    func initViews(){
        
        
        for item in arrayOfViews{
            self.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            [item.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0),
            item.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            item.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, constant: 0),
            item.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
            item.navigationDelegate = self
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: { [weak self] in
            self?.arrayOfViews[0].transform = CGAffineTransform.init(translationX: 0, y: -(self?.guide.layoutFrame.height ?? 0))
        }, completion: nil)
        
        
    }
    
    
    
    func initiateGestureRecogniser(){
        edgeSwipeGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgeSwipeDetected(sender:)))
        edgeSwipeGesture.edges = .right
        arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
    }
    
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    deinit {
        print("StackManager deinit called")
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
    
    func performInitialAnimation(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            self.arrayOfViews[0].transform = CGAffineTransform.init(translationX: 0, y: -self.guide.layoutFrame.height)
        }, completion: nil)
    }
}

protocol StackViewDimensionProtocol: UIView{
    var state: ViewState { get set }
    var navigationDelegate: StackNavigationProtocol? { get set }
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
        }) { [weak self] (_) in
            guard let _ = self else { return }
            if self!.currentScene > 0{
                self!.currentScene -= 1
                self!.arrayOfViews[self!.currentScene].addGestureRecognizer(self!.edgeSwipeGesture)
            } else{
                
                self!.arrayOfViews[self!.currentScene].removeFromSuperview()
                self!.removeFromSuperview()
            }
        }
        
        
    }
    
    
}
