//
//  CreatePostController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Firebase

class CreatePostController: UIViewController {

    private let postView = CreatePostView()
    override func loadView() {
        view = postView
    }
    
    private let databaseService = DatabaseService.shared
    
    public var organization: User
    
    private var keyboardIsVisible = false
    
    private var descriptionText = "Testing posting"
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterKeyboardNotifications()
    }
    
    private func setupVC() {
        postView.backgroundColor = UIColor(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        postView.dateTF.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        postView.submitButton.addTarget(self, action: #selector(submitButtonPressed(_:)), for: .touchUpInside)
        postView.descriptionTV.delegate = self
        registerKeyboardNotifications()
    }
    

    @objc func tapDone() {
        if let datePicker = self.postView.dateTF.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.postView.dateTF.text = dateformatter.string(from: datePicker.date)
        }
        self.postView.dateTF.resignFirstResponder()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        guard let titleText = postView.listingTitleTF.text, !titleText.isEmpty, let location = postView.locationTF.text, !location.isEmpty, let date = postView.dateTF.text, !date.isEmpty, !descriptionText.isEmpty else {
            showAlert(title: "Missing Fields", message: "Please enter all required fields")
            return
        }
        print("button pressed")
        
        let post = Post(id: "1", description: descriptionText, shortDescription: titleText, location: location, category: "", startDate: Timestamp(date: Date()), endDate: Timestamp(date: Date()), status: "unfulfilled", imageURL: "")
        
        databaseService.addPost(post: post) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Error:", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Listing Posted", message: "")
                }
            }
        }
        
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        moveKeyboardUp(keyboardFrame.size.height)
    }
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        
        UIView.animate(withDuration: 0.3) {
            
//            self.postView.orgIVTopAnchor?.isActive = false
            
            self.postView.orgIVTopAnchor = self.postView.organizationIV.topAnchor.constraint(equalTo: self.postView.bottomAnchor, constant: -(height + 0)
            )
            self.postView.orgIVTopAnchor?.isActive = true
            self.postView.layoutIfNeeded()
            
        }
        
        keyboardIsVisible = true
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        resetUI()
    }
    private func resetUI() {
        keyboardIsVisible = false
        
        UIView.animate(withDuration: 0.3) {
            self.postView.orgIVTopAnchor?.isActive = false
            self.postView.orgIVTopAnchor = self.postView.organizationIV.topAnchor.constraint(equalTo: self.postView.bottomAnchor, constant: 0)
            self.postView.orgIVTopAnchor?.isActive = true
            self.postView.layoutIfNeeded()
        }
    }
}

extension CreatePostController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("in text view")
        keyboardIsVisible = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            keyboardIsVisible = false
            return false
        }
        return true
    }
}
