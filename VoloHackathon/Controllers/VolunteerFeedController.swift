//
//  VolunteerFeedController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class VolunteerFeedController: UIViewController {

    private var volunteerFeedView = VolunteerView()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.volunteerFeedView.collectionView.reloadData()
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

        configureCollectionView()
        getPosts()
        

    }
    
    private func configureCollectionView() {
        
        volunteerFeedView.collectionView.delegate = self
        volunteerFeedView.collectionView.dataSource = self
        volunteerFeedView.collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
        
    }
    
    private func getPosts() {
        DatabaseService.shared.fetchAllPosts { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error getting faved events: \(error.localizedDescription)")
            case .success(let posts):
                self?.posts = posts
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
        
        let detailVC = PostDetailController()
        // should pass a post 
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
