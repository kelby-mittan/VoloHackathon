//
//  UserTableViewController.swift
//  VoloHackathon
//
//  Created by Brendon Cecilio on 4/22/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class UserTableViewController: UIViewController {
    
    private let tableView = UserTableView()
    public var selectedPost: Post?
    private var listedUsers = [User]() {
        didSet {
            DispatchQueue.main.async {
                if self.listedUsers.isEmpty {
                    self.tableView.tableView.backgroundView = EmptyView(title: "No Users", message: "No one is interested in your opportunity.", imageName: "volunteer")
                } else {
                    self.tableView.tableView.backgroundView = nil
                }
                self.tableView.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.tableView.delegate = self
        tableView.tableView.dataSource = self
        tableView.tableView.register(ListedUserCell.self, forCellReuseIdentifier: "listedCell")
        getInterestedUsers()
    }
    
    private func getInterestedUsers() {
        DatabaseService.shared.fetchVolunteers(post: selectedPost!) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("error fetching volunteers: \(error)")
            case .success(let users):
                self?.listedUsers = users
            }
        }
    }
}

extension UserTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listedCell", for: indexPath) as? ListedUserCell else {
            fatalError("could not downcast ListedUserCell")
        }
        let userInfo = listedUsers[indexPath.row]
        cell.configureUserCell(user: userInfo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
