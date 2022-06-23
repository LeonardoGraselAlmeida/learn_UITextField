//
//  ViewControllerDefault.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 23/06/22.
//

import UIKit

class ViewControllerDefault: UIViewController {
    var afterHideKeyboard: (() -> Void)?
    var afterShowKeyboard: ((_ heightKeyboard: CGFloat) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _: NSObjectProtocol = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
            
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= value.cgRectValue.height - 200
            }
            
            self.afterShowKeyboard?(value.cgRectValue.height)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    func hideKeyboardByTappingOutside() {
        view.endEditing(true)
        
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
        
        afterHideKeyboard?()
    }
  
}
