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
        updateUI()
        print(post.category)

    }
    
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveButtonPressed(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc func saveButtonPressed(sender: UIBarButtonItem) {
        print("saved")
        // this will save this post to the users "saved posts" collection for a specific user
    }
    
    @objc func volunteerButtonPressed(sender: UIButton) {
        // add current user to a list of potential volunteers of a specific post 
    }
    
    private func updateUI() {
        
        detailView.backgroundImage.kf.setImage(with: URL(string: post.imageURL))
        detailView.mainImage.kf.setImage(with: URL(string: post.imageURL))
        detailView.largeLabel.text = post.shortDescription
        detailView.smallLabel2.text = post.description
        
    }

}
