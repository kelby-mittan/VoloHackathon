//
//  CreatePostController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class CreatePostController: UIViewController {

    private let postView = CreatePostView()
    override func loadView() {
        view = postView
    }
    
    public var organization: User
    
    init?(organization: User) {
        self.organization = organization
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVC()
    }
    
    private func setupVC() {
        postView.backgroundColor = UIColor(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.postView.dateTF.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    

    @objc func tapDone() {
        if let datePicker = self.postView.dateTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.postView.dateTF.text = dateformatter.string(from: datePicker.date)
        }
        self.postView.dateTF.resignFirstResponder()
    }
}
