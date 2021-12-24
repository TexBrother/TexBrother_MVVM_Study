//
//  BaseViewController.swift
//  Finut
//
//  Created by 노한솔 on 2021/09/02.
//

import Foundation
import UIKit
import RxSwift

// MARK: - BaseViewController

class BaseViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    public let disposeBag = DisposeBag()
    public let loadingHudTrigger = PublishSubject<Bool>()
    public var recognizer: UIPanGestureRecognizer?
    
    @objc
    public func swipeRecognizer() {
        let popGestureRecognizer = self.navigationController?.interactivePopGestureRecognizer!
        if let targets = popGestureRecognizer?.value(forKey: "targets") as? NSMutableArray {
            let gestureRecognizer = UIPanGestureRecognizer()
            recognizer = gestureRecognizer
            gestureRecognizer.setValue(targets, forKey: "targets")
            self.view.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    var scrollViewContainer: UIScrollView?
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(
            forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        if let scrollViewContainer = scrollViewContainer {
            scrollViewContainer.contentInset.bottom = keyboardRectangle.height
        }
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        if let scrollViewContainer = scrollViewContainer {
            scrollViewContainer.contentInset.bottom = 0
        }
    }
    
    @objc
    func keyboardWillAppear(_ notification: Notification) {
        
    }
    
    @objc
    func keyboardDidAppear(_ notification: Notification) {
        
    }
    
    @objc
    func keyboardWillDisappear(_ notification: Notification) {
        
    }
    
    @objc
    func keyboardDidDisappear(_ notification: Notification) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .backgroundColor
        swipeRecognizer()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillAppear(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidAppear(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDisappear(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidDisappear(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        
        //    loadingHudTrigger.bind(to: LoadingHUD.rx.isAnimating)
        //      .disposed(by: disposeBag)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit", self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        /// Dispose of any resources that can be recreated.
    }
}


