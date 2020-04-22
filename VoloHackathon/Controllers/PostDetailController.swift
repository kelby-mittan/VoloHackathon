//
//  PostDetailController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Kingfisher

class PostDetailController: UIViewController {
    
    private var detailView = DetailView()
    private var post: Post
    
    init(_ post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavBar()
        // not working - i think the scroll view gesture is interfering with the buttons gesture so its
        detailView.volunteerButton.addTarget(self, action: #selector(volunteerButtonPressed(_:)), for: .touchUpInside)
        updateUI()
        print(post.category)
        
    }
    
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveButtonPressed(_:)))
        
        let tempVolunteerButton = UIBarButtonItem(image: UIImage(named: "hand.heart"), style: .plain, target: self, action: #selector(volunteerButtonPressed(_:)))
        tempVolunteerButton.tintColor = .black
        saveButton.tintColor = .black
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveButtonPressed(_:)))
//        navigationItem.rightBarButtonItem?.tintColor = .black
        
        navigationItem.rightBarButtonItems = [saveButton, tempVolunteerButton]
        
        
    }
    
    @objc func saveButtonPressed(_ sender: UIBarButtonItem) {
        // this will save this post to the users "saved posts" collection for a specific user
                
        DatabaseService.shared.addToInterests(post: post) { (result) in
            switch result {
            case .failure(let error):
                print("error saving post to interested: \(error)")
            case .success: //(let isSaved):
                print("\(self.post.category) should have been saved to the users saved")
                // present an alert telling them it was added to saved - maybe this should only happen once ?
                
            }
        }
    }
    
    @objc func volunteerButtonPressed(_ sender: UIBarButtonItem) {    //(_ sender: UIButton) doing this for the sake of testing
        print("I want to volunteer")
        
        
        // add current user to a list of potential volunteers of a specific post
        
        // addToCommittments -> shouldnt this take in a user not a post?
        
        // should present an alert controller "We'll let \(post.orgName) know youre interested" "Ok" , "No, I change my mind"
        
         //       DatabaseService.shared.addToCommittments(post: post) { (result) in
        //                    switch result {
        //                    case .failure(let error):
        //                        print("error saving post to interested: \(error)")
        //                    case .success: //(let isSaved):
        //                        print("\(self.post.category) should have been saved to the users saved")
        //                        // present an alert telling them it was added to saved - maybe this should only happen once ?
        //
        //                    }
        //                }
        
    }
    
    private func updateUI() {
        
        detailView.backgroundImage.kf.setImage(with: URL(string: post.imageURL))
        detailView.mainImage.kf.setImage(with: URL(string: post.imageURL))
        detailView.largeLabel.text = post.shortDescription
        detailView.smallLabel2.text = post.description
        
    }
    
}
