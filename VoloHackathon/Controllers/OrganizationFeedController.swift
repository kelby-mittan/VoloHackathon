//
//  OrganizationFeedController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class OrganizationFeedController: UIViewController {
    
    private var volunteerFeedView = VolunteerView()
    
    private var addPostButton: UIBarButtonItem!
    
    override func loadView() {
        view = volunteerFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Organization"
        
        addPostButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPostPressed(_:)))
        navigationItem.rightBarButtonItem = addPostButton
        
        configureCollectionView()
        
        
    }
    
    private func configureCollectionView() {
        
        volunteerFeedView.collectionView.delegate = self
        volunteerFeedView.collectionView.dataSource = self
        volunteerFeedView.collectionView.register(PostCell.self, forCellWithReuseIdentifier: "orgPostCell")
        
    }
    
    @objc func addPostPressed(_ sender: UIBarButtonItem) {
        
        
        guard let createPostVC = CreatePostController(organization: User(userId: "", name: "kelby", location: "here", imageURL: "", userType: "", verified: "")) else { return }
        
        navigationController?.pushViewController(createPostVC, animated: true)
    }
    
}

extension OrganizationFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orgPostCell", for: indexPath) as? PostCell else {
            fatalError("could not down cast to post cell")
        }
        
        cell.backgroundColor = .white
        
        return cell
    }
}

extension OrganizationFeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.35
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = PostDetailController()
        // should pass a post
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
