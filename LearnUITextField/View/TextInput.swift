//
//  UITextFieldCustom.swift
//  LearnUITextField
//
//  Created by Leonardo Almeida on 16/06/22.
//

import UIKit

class TextInput: UITextField {
    let textPadding = UIEdgeInsets(
        top: 5,
        left: 10,
        bottom: 5,
        right: 10
    )
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        
        keyboardType = .default
        returnKeyType = .next
        font = .systemFont(ofSize: 18)
        textColor = .black
        
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
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
