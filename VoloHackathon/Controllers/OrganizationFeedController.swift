//
//  OrganizationFeedController.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class OrganizationFeedController: UIViewController {
    
    private var volunteerFeedView = VolunteerView()
    
    private var addPostButton: UIBarButtonItem!
    
    override func loadView() {
        view = volunteerFeedView
    }
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.volunteerFeedView.collectionView.reloadData()
            }
        }
    }
    
    var orgUser: User?
    
    let orgId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Organization"
        
        addPostButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPostPressed(_:)))
        navigationItem.rightBarButtonItem = addPostButton
        
        configureCollectionView()
        
        getPosts()
    }
    
    private func configureCollectionView() {
        
        volunteerFeedView.collectionView.delegate = self
        volunteerFeedView.collectionView.dataSource = self
        volunteerFeedView.collectionView.register(PostCell.self, forCellWithReuseIdentifier: "orgPostCell")
        
    }
    
    private func getPosts() {
        DatabaseService.shared.fetchAllPosts { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error getting volunteer post: \(error.localizedDescription)")
            case .success(let posts):
                self?.posts = posts.filter { $0.id == self?.orgId }
            }
        }
    }
    
    @objc func addPostPressed(_ sender: UIBarButtonItem) {
        
        guard let user = Auth.auth().currentUser else { return }
        
        DatabaseService.shared.fetchUserInfo(userId: user.uid) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("\(error) getting userInfo")
            case .success(let users):
                guard let user = users.first, let createPostVC = CreatePostController(organization: user) else { return }
                
                self?.navigationController?.pushViewController(createPostVC, animated: true)
            }
        }

    }
    
}

extension OrganizationFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "orgPostCell", for: indexPath) as? PostCell else {
            fatalError("could not down cast to post cell")
        }
        let post = posts[indexPath.row]
        cell.backgroundColor = .white
        cell.configureCell(post)
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
        
        
    }
}
