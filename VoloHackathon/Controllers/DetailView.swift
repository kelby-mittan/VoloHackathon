//
//  DetailView.swift
//  VoloHackathon
//
//  Created by Amy Alsaydi on 4/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class DetailView: UIView {

   public lazy var scrollView: UIScrollView = {
       let scrollview = UIScrollView()
       scrollview.backgroundColor = .clear
       return scrollview
   }()
   
   public lazy var contentView: UIView = {
       let view = UIView()
       view.backgroundColor = .clear
       return view
   }()
   
   public lazy var backgroundImage: UIImageView = {
       let iv = UIImageView()
       iv.contentMode = .scaleAspectFill
       iv.image = UIImage(named: "noimage")
       iv.clipsToBounds = true
       iv.alpha = 1
       return iv
   }()
   
   
   public lazy var blur: UIVisualEffectView = {
       let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.extraLight))
       return blur
   }()
   
   public lazy var mainImage: UIImageView = {
       let iv = UIImageView()
       iv.image = UIImage(named: "noimage")
       iv.contentMode = .scaleAspectFill
       iv.clipsToBounds = true
       return iv
   }()
   
   public lazy var largeLabel: UILabel = {
       let label = UILabel()
       label.text = "Large Label"
       label.numberOfLines = 0
       label.font = UIFont.boldSystemFont(ofSize: 30)
       return label
   }()
    
    public lazy var smallLabel1: UILabel = { // eventTime or date created date
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    public lazy var smallLabel2: UILabel = { // description or price range
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    public lazy var smallLabel3: UILabel = { // link to event place produced
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .thin)
        return label
    }()

}
