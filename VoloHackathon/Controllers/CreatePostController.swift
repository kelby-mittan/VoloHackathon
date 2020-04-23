//
//  CreatePostController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CreatePostController: UIViewController {

    private let postView = CreatePostView()
    override func loadView() {
        view = postView
    }
    
    private let databaseService = DatabaseService.shared
    
    public var organization: User
    
    private var keyboardIsVisible = false
    
    private var descriptionText = "Testing posting"
    
    var heightAnchor: NSLayoutConstraint!
    
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
        setupTFDelegates()
        print(organization.userType)
    }
    
    private func setupVC() {
        postView.backgroundColor = UIColor(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = false
        postView.dateTF.setInputViewDatePicker(target: self, selector: #selector(tapDone))
        postView.submitButton.addTarget(self, action: #selector(submitButtonPressed(_:)), for: .touchUpInside)
        postView.descriptionTV.delegate = self
        heightAnchor = postView.organizationIV.heightAnchor.constraint(equalTo: postView.heightAnchor, multiplier: 0.21)
        heightAnchor.isActive = true
    }
    
    private func setupTFDelegates() {
        postView.listingTitleTF.delegate = self
        postView.locationTF.delegate = self
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
        
        guard let orgId = Auth.auth().currentUser?.uid else { return }
        
        guard let titleText = postView.listingTitleTF.text, !titleText.isEmpty, let location = postView.locationTF.text, !location.isEmpty, let date = postView.dateTF.text, !date.isEmpty, !descriptionText.isEmpty else {
            showAlert(title: "Missing Fields", message: "Please enter all required fields")
            return
        }
        print("button pressed")
        
//        let post = Post(id: orgId, description: descriptionText, shortDescription: titleText, location: location, category: "", startDate: date, postDate: Timestamp(date: Date()), status: "unfulfilled", imageURL: "")
        let postId = UUID().uuidString
        
        let post = Post(orgId: orgId, description: descriptionText, shortDescription: titleText, location: location, category: "", startDate: date, postDate: Timestamp(date: Date()), status: "unfulfilled", imageURL: "", postId: postId)
        
        databaseService.addPost(post: post) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Post Error:", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
//                    self?.showAlert(title: "Listing Posted", message: "")
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
}

extension CreatePostController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("in text view")
        postView.descriptionTV.text = ""
        heightAnchor.isActive = false
        heightAnchor = postView.organizationIV.heightAnchor.constraint(equalToConstant: 0)
        heightAnchor.isActive = true
        keyboardIsVisible = true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            heightAnchor.isActive = false
            heightAnchor = postView.organizationIV.heightAnchor.constraint(equalTo: postView.heightAnchor, multiplier: 0.21)
            heightAnchor.isActive = true
            keyboardIsVisible = false
            return false
        }
        return true
    }
}

extension CreatePostController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        postView.listingTitleTF.resignFirstResponder()
        postView.locationTF.resignFirstResponder()
        return true
    }
    
}


