//
//  VolunteerFeedController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import FirebaseAuth

class VolunteerFeedController: UIViewController {

    private var volunteerFeedView = VolunteerView()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.volunteerFeedView.collectionView.reloadData()
            }
        }
    }
    
    private var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.getPosts(self.searchQuery)
            }
        }
    }
    
    override func loadView() {
        view = volunteerFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Volunteer"
        volunteerFeedView.searchBar.delegate = self
        volunteerFeedView.searchBar.placeholder = "Search for opportunities"

        configureCollectionView()
        getPosts()
        getUserInfo()
        

    }
    
    private func configureCollectionView() {
        
        volunteerFeedView.collectionView.delegate = self
        volunteerFeedView.collectionView.dataSource = self
        volunteerFeedView.collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
        
    }
    
    private func getPosts(_ searchQuery: String? = nil) {
        DatabaseService.shared.fetchAllPosts { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error getting volunteer post: \(error.localizedDescription)")
            case .success(let posts):
                if searchQuery == nil {
                    self?.posts = posts
                } else {
                    self?.posts = posts.filter { $0.shortDescription == searchQuery }
                }
                
            }
        }
    }
    
    private func getUserInfo() {
           guard let user = Auth.auth().currentUser else { return }
           
           DatabaseService.shared.fetchUserInfo(userId: user.uid) { [weak self] (result) in
               switch result {
               case .failure(let error):
                   print("\(error) getting userInfo")
               case .success(let users):
                   guard let user = users.first else { return }
                   
                   self?.navigationItem.title = "Welcome \(user.name.capitalized)!"
               }
           }
       }

}

extension VolunteerFeedController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? PostCell else {
            fatalError("could not down cast to post cell")
        }
        
        cell.backgroundColor = .white
        let post = posts[indexPath.row]
        cell.configureCell(post)
        return cell
    }
}

extension VolunteerFeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxsize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxsize.width
        let itemHeight: CGFloat = maxsize.height * 0.35
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let detailVC = PostDetailController(post)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension VolunteerFeedController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            print("search text issue")
            return
        }
        
        searchQuery = searchText
    }
}
