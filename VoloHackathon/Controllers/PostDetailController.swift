//
//  PostDetailController.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class PostDetailController: UIViewController {
    
    private var detailView = DetailView()
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "square.and.arrow.down")

    }

}
