//
//  ViewController.swift
//  Animation
//
//  Created by Yaroslav on 10/3/19.
//  Copyright © 2019 Yaroslav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let loadingIndicator = ActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingIndicator)
        loadingIndicator.setup()
//        loadingIndicator.startAnimate()
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 150).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
}

