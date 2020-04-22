//
//  PostDetailController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth

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
        // saveButton.tintColor = .black
        
        
        
        navigationItem.rightBarButtonItems = [saveButton]
        
        
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
        
        showOptionsAlert(title: "Ready to Help?", message: "We'll let them know youre interested", yesText: "Ok", noText: "Not yet") { (alertAction) in
            
            guard let user = Auth.auth().currentUser else { return }
            
            
            DatabaseService.shared.fetchUserInfo(userId: user.uid) { (result) in
                switch result {
                case .failure(let error):
                    print("\(error) getting userInfo")
                case .success(let volunteers):
                    guard let volunteer = volunteers.first else {
                        print("no user - post detail VC")
                        return
                    }
                    DatabaseService.shared.addVolunteer(post: self.post, volunteer: volunteer) { (result) in
                        switch result {
                        case .failure(let error):
                            print("error adding volunteer to post list \(error.localizedDescription)")
                        case .success:
                            print("successfully added volunteer")
                        }
                    }
                    
                }
            }
            
        }
        
    }
    
    private func updateUI() {
        
        detailView.backgroundImage.kf.setImage(with: URL(string: post.imageURL))
        detailView.mainImage.kf.setImage(with: URL(string: post.imageURL))
        detailView.largeLabel.text = post.shortDescription
        detailView.smallLabel2.text = post.description
        
    }
    
}
