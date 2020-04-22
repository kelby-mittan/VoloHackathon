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
    
    override func loadView() {
        view = tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UserTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
