//
//  ToggleButtonClass.swift
//  VoloHackathon
//
//  Created by Brendon Cecilio on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    
    var isOn: Bool = false
    let salmonColor = UIColor(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    static let shared = ToggleButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = salmonColor.cgColor
        layer.cornerRadius = 10
        
        setTitleColor(salmonColor, for: .normal)
        addTarget(self, action: #selector(ToggleButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        let color = bool ? salmonColor : . clear
        let titleColor = bool ? .white : salmonColor
        
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
    }
}
