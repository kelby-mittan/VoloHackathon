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
    
    private var listener: ListenerRegistration?
    
    var orgUser: User?
    
    let orgId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addPostButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addPostPressed(_:)))
        navigationItem.rightBarButtonItem = addPostButton
        
        configureCollectionView()
        getOrgInfo()
        getPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        listener = Firestore.firestore().collection(DatabaseService.posts).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "try again", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map { Post($0.data()) }
                self?.posts = posts.sorted { $0.postDate.dateValue() > $1.postDate.dateValue() }.filter { $0.orgId == self?.orgId }
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
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
                self?.posts = posts.filter { $0.orgId == self?.orgId }
            }
        }
    }
    
    private func getOrgInfo() {
        guard let user = Auth.auth().currentUser else { return }
        
        DatabaseService.shared.fetchUserInfo(userId: user.uid) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("\(error) getting userInfo")
            case .success(let users):
                guard let user = users.first else { return }
                
                self?.orgUser = user
                self?.navigationItem.title = user.name
            }
        }
    }
    
    @objc func addPostPressed(_ sender: UIBarButtonItem) {
        
        guard let user = orgUser, let createPostVC = CreatePostController(organization: user) else {
            fatalError()
        }
        
        navigationController?.pushViewController(createPostVC, animated: true)
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
        
        let post = posts[indexPath.row]
        
        let TVController = UserTableViewController()
        
        TVController.selectedPost = post
        
        navigationController?.pushViewController(TVController, animated: true)
    }
}
