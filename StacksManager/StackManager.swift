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
    var swipeUpGesture: UIPanGestureRecognizer!
    var arrayOfViews: [StackViewDataSource]!{
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
    
    
    /// REQUIRED : Use the below init to pass in the required params for StackManager to work
    public convenience init(frame: CGRect,viewStack: [StackViewDataSource],guide: UILayoutGuide) {
        self.init()
        
        do{
            try buildManager(frame: frame,viewStack: viewStack,guide: guide)
        } catch {
            print("Error : \(error)")
        }
    }
    
    func buildManager(frame: CGRect,viewStack: [StackViewDataSource],guide: UILayoutGuide) throws {
        if viewStack.count < 2{
            throw ViewStackError.errorViewCount("View Stack needs at least 2 views")
        }
        self.frame = frame
        self.guide = guide
        self.arrayOfViews = viewStack
        self.arrayOfViews[0].state = .Visible
        initViews()
        initiateGestureRecogniser()
    }
    
    func initiateGestureRecogniser(){
        edgeSwipeGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgeSwipeDetected(sender:)))
        edgeSwipeGesture.edges = .right
        arrayOfViews[currentScene].addGestureRecognizer(edgeSwipeGesture)
        
        dismissTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissPresentedViews(sender:)))
        dismissTapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(dismissTapGesture)
        
    }
    
    
    @objc func dismissPresentedViews(sender: UITapGestureRecognizer){
        let location = sender.location(in: self)
        for view in arrayOfViews.reversed(){
            if view.frame.contains(location){
                guard let index = arrayOfViews.firstIndex(where: { $0 === view }) else { return }
                if index > currentScene{
                    view.state = .Visible
                    self.moveForward()
                    return
                }
                if index < currentScene{
                    for i in (index + 1)...arrayOfViews.count-1{
                        arrayOfViews[i].state = .Dismissed
                        self.dismissCurrentView()
                    }
                    return
                }
                return
            }
        }
    }
    
    @objc func edgeSwipeDetected(sender: UIPanGestureRecognizer){
        var dismissable = false
        if sender.translation(in: sender.view).x < -100 {
            dismissable = true
        }
        if sender.state == .ended{
            if dismissable{
                if currentScene == 0{
                 dismissAllStacks()
                }
                arrayOfViews[currentScene].state = .Dismissed
                self.dismissCurrentView()
            }
        }
    }
    
    /// This method can be called from any stack view to dimiss all the stacks at a time.
    ///This can be called from any stack via the StackNavigationProtocol property.
     
    ///Example can be seen in Sample app's StashAmountSelectionView's initViews method. Uncomment the closeButton and target to see the functionality.
    public func dismissAllStacks(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut,.curveEaseIn], animations: {
            self.transform = CGAffineTransform.init(translationX: 0, y: self.frame.height)
        }) { (_) in
            self.removeFromSuperview()
        }
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
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: { [weak self] in
            self?.arrayOfViews[0].transform = CGAffineTransform.init(translationX: 0, y: -(self?.guide.layoutFrame.height ?? 0))
            self?.arrayOfViews[1].transform = CGAffineTransform.init(translationX: 0, y: -80)
        }, completion: nil)
    }
    
    deinit {
        print("StackManager deinit called")
    }
    
    
    
    func performInitialAnimation(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            self.arrayOfViews[0].transform = CGAffineTransform.init(translationX: 0, y: -self.guide.layoutFrame.height)
        }, completion: nil)
    }
}

///REQUIRED DataSource protocol. All UIVIew objects that are passed to StackManager must confirm to this protocol
public protocol StackViewDataSource: UIView{
    ///state of item in Stack
    var state: ViewState { get set }
    ///This is a required property to  add custom actions to move forward or backward in the stacks.
    var navigationDelegate: StackNavigationProtocol? { get set }
    ///Required for StackManager to identify translation values of next view
    func heightOfHeaderView() -> CGFloat
    ///Recieve a any values that is passed by the previous view in stack
    func recieveIncomingData(value: Any?)
    ///Send any values to the next view in Stack
    func sendDataToNextView() -> Any?
}

///Custom navigation protocol
public protocol StackNavigationProtocol: AnyObject{
    func moveForward()
    func dismissCurrentView()
    func dismissStackManager()
}

public enum ViewState{
    case Dismissed
    case Visible
    case Background
    case FullScreen
}



extension StackManager: StackNavigationProtocol{
    public func dismissStackManager() {
        self.dismissAllStacks()
    }
    
    
    /// Any time an action is performed to move to the succeeding view in the stack. Called from within the StackManager on the usual TapGesture
    public func moveForward() {
        let dataForNextView = arrayOfViews[currentScene].sendDataToNextView()
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            var heightOffest: CGFloat = 0
            for i in 0...self!.currentScene{
                heightOffest = heightOffest + self!.arrayOfViews[i].heightOfHeaderView()
            }
            self!.arrayOfViews[self!.currentScene].state = .Background
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
    
    ///Any time an action is performed to move back to the previous view in the stack. Called from within the StackManager on the Edge Swipe Gesture and Tap Gesture on previously visible views.
    public func dismissCurrentView() {
        if currentScene == 0{
            return
        }
        self.currentScene -= 1
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: { [weak self] in
            guard let _ = self else { return }
            for i in (self!.currentScene + 1)...self!.arrayOfViews.count - 1{
                self!.arrayOfViews[i].transform  = .identity
            }
            self!.arrayOfViews[self!.currentScene + 1].transform = CGAffineTransform.init(translationX: 0, y: -80)
        }) { [weak self] (_) in
            guard let _ = self else { return }
                self!.arrayOfViews[self!.currentScene].addGestureRecognizer(self!.edgeSwipeGesture)
        }
    }
}


enum ViewStackError: Error{
    case errorViewCount(String)
}
