//
//  UITextFieldCustom.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 16/06/22.
//

import UIKit

class TextInputDefault: UITextField {
    let textPadding = UIEdgeInsets(
        top: 5,
        left: 10,
        bottom: 5,
        right: 10
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDefault()
    }
    
    func initDefault() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        keyboardType = .default
        returnKeyType = .next
        font = .systemFont(ofSize: 18, weight: .regular)
        textColor = .black
        
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()

            for view in subviews {
                if let button = view as? UIButton {
                    button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
                    button.tintColor = .black
                }
            }
        }
}
