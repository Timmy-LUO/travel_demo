//
//  RadioButton.swift
//  DailyBellePOS
//
//  Created by Harry on 2023/1/28.
//

import UIKit

public protocol RadioButtonDelegate {
    func onClicked(radioButton: RadioButton)
}

final public class RadioButton: UIButton {
    
    public var delegate: RadioButtonDelegate?
    override public var buttonType: UIButton.ButtonType { .custom }
    private var _borderWidth: CGFloat = 1

    override public var isSelected: Bool {
        didSet { setIsSelected() }
    }
    
    convenience init(borderWidth: CGFloat) {
        self.init(frame: .zero)
        self._borderWidth = borderWidth
        commonInit()
    }
    
    private func commonInit() {
        layer.cornerRadius = 5
        layer.borderColor = "blue_0080FF".color.cgColor
        layer.borderWidth = _borderWidth
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        titleLabel?.font = .systemFont(ofSize: 18)
        setTitleColor("white_FFFFFF".color, for: .normal)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isSelected = !isSelected
        delegate?.onClicked(radioButton: self)
    }
    
    private func setIsSelected() {
        if isSelected {
            layer.borderWidth = 0
            backgroundColor = "blue_0080FF".color
            setTitleColor("white_FFFFFF".color, for: .normal)
        } else {
            layer.borderWidth = _borderWidth
            backgroundColor = "white_FFFFFF".color
            setTitleColor("blue_0080FF".color, for: .normal)
        }
    }
}
