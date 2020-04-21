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
        configureNavBar()
        updateUI()

    }
    
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .plain, target: self, action: #selector(saveButtonPressed(sender:)))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc func saveButtonPressed(sender: UIBarButtonItem) {
        print("saved")
    }
    
    private func updateUI() {
        // update the post 
        
    }

}
