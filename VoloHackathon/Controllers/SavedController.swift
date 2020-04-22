//
//  SavedController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class SavedController: UIViewController {
    
    private var savedView = VolunteerView()
    
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                if self.posts.isEmpty {
                    self.savedView.collectionView.backgroundView = EmptyView(title: "No Volunteering Saved Yet", message: "Find saved volunteering here. Click on save button on the top left to save.", imageName: "volunteer")
                } else {
                    self.savedView.collectionView.backgroundView = nil
                }
                
                self.savedView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = savedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Saved Opportunities"
        configureCollectionView()

        // Do any additional setup after loading the view.
    }
    
    private func configureCollectionView() {
        
        savedView.collectionView.delegate = self
        savedView.collectionView.dataSource = self
        savedView.collectionView.register(PostCell.self, forCellWithReuseIdentifier: "postCell")
        getSavedPosts()
        
    }
    
    private func getSavedPosts() {
        DatabaseService.shared.fetchInterests { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error getting faved events: \(error.localizedDescription)")
            case .success(let posts):
                self?.posts = posts
            }
        }
    }

}

extension SavedController: UICollectionViewDataSource {
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

extension SavedController: UICollectionViewDelegateFlowLayout {
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
