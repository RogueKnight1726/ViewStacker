//
//  StackManager.swift
//  StacksManager
//
//  Created by Next on 01/08/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


public class StackManager: UIView{
    
    var edgeSwipeGesture: UIScreenEdgePanGestureRecognizer!
    var dismissTapGesture: UITapGestureRecognizer!
    
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
    
    public convenience init(frame: CGRect,viewStack: [StackViewDimensionProtocol],guide: UILayoutGuide) {
        self.init()
        self.frame = frame
        self.guide = guide
        self.arrayOfViews = viewStack
        initViews()
        initiateGestureRecogniser()
    }
    
    func initViews(){
        
        self.transform = .identity
        for item in arrayOfViews{
            self.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            [item.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 0),
            item.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: 0),
            item.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, constant: 0),
            item.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
            item.navigationDelegate = self
            item.transform = .identity
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: { [weak self] in
            self?.arrayOfViews[0].transform = CGAffineTransform.init(translationX: 0, y: -(self?.guide.layoutFrame.height ?? 0))
            self?.arrayOfViews[1].transform = CGAffineTransform.init(translationX: 0, y: -80)
        }, completion: nil)
        
        
    }
    
    
    
    func initiateGestureRecogniser(){
        edgeSwipeGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgeSwipeDetected(sender:)))
        edgeSwipeGesture.edges = .right
        arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
        
        dismissTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissPresentedViews(sender:)))
        self.addGestureRecognizer(dismissTapGesture)
    }
    
    @objc func dismissPresentedViews(sender: UITapGestureRecognizer){
        
        let location = sender.location(in: self)
        for view in arrayOfViews.reversed(){
            print("For loop called")
            if view.frame.contains(location){
                guard let index = arrayOfViews.firstIndex(where: { $0 === view }) else { return }
                print("Index initiated at \(index)")
                if index > currentScene{
                    view.state = .Visible
                    return
                }
                if index < currentScene{
                    for i in (index + 1)...arrayOfViews.count-1{
                        print("Dismiss called for index \(index)")
                        arrayOfViews[i].state = .Dismissed
                    }
                    return
                }
                return
            }
        }
        
        
    }
    
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
    }
    
    deinit {
        print("StackManager deinit called")
    }
    
    @objc func edgeSwipeDetected(sender: UIPanGestureRecognizer){
        var dismissable = false
        if sender.translation(in: sender.view).x < -100 {
            dismissable = true
        }
        if sender.state == .ended{
            if dismissable{
                if currentScene == 0{
                 dismissStackManager()
                }
                arrayOfViews[currentScene].state = .Dismissed
            }
        }
    }
    
    func dismissStackManager(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y: self.frame.height)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func performInitialAnimation(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            self.arrayOfViews[0].transform = CGAffineTransform.init(translationX: 0, y: -self.guide.layoutFrame.height)
        }, completion: nil)
    }
}

public protocol StackViewDimensionProtocol: UIView{
    var state: ViewState { get set }
    var navigationDelegate: StackNavigationProtocol? { get set }
    func heightOfHeaderView() -> CGFloat
    func recieveIncomingData(value: Any?)
    func sendDataToNextView() -> Any?
//    func heightOfView() -> CGFloat
}


public protocol StackNavigationProtocol: AnyObject{
    
    func moveForward()
    func dismissCurrentView()
}

public enum ViewState{
    case Dismissed
    case Visible
    case FullScreen
}



extension StackManager: StackNavigationProtocol{
    public func moveForward() {
        let dataForNextView = arrayOfViews[currentScene].sendDataToNextView()
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            var heightOffest: CGFloat = 0
            for i in 0...self!.currentScene{
                heightOffest = heightOffest + self!.arrayOfViews[i].heightOfHeaderView()
            }
            self!.arrayOfViews[self!.currentScene + 1].transform = CGAffineTransform.init(translationX: 0, y: -(self!.guide.layoutFrame.height - heightOffest))
            if self!.arrayOfViews.indices.contains(self!.currentScene + 2){
                self!.arrayOfViews[self!.currentScene + 2].transform = CGAffineTransform.init(translationX: 0, y: -80)
            }
        }, completion: nil)
        if currentScene <= arrayOfViews.count{
            
            currentScene += 1
            arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
            arrayOfViews[currentScene].recieveIncomingData(value: dataForNextView)
        }
    }
    
    public func dismissCurrentView() {
        print("Current Scene : \(currentScene)")
        
        if currentScene == 0{
            return
        }
        self.currentScene -= 1
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            for i in (self!.currentScene + 1)...self!.arrayOfViews.count - 1{
                self!.arrayOfViews[i].transform  = .identity
            }
            self!.arrayOfViews[self!.currentScene + 1].transform = CGAffineTransform.init(translationX: 0, y: -80)
        }) { [weak self] (_) in
            guard let _ = self else { return }
            if self!.currentScene >= 0{
//                self!.currentScene -= 1
                self!.arrayOfViews[self!.currentScene].addGestureRecognizer(self!.edgeSwipeGesture)
            } else{

                self!.arrayOfViews[max(self!.currentScene,0)].removeFromSuperview()
                self!.removeFromSuperview()
            }
        }
        
        
    }
    
    
}
