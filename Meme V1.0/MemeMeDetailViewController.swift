//
//  MemeMeDetailViewController.swift
//  Meme V1.0
//
//  Created by pu yang on 2/3/18.
//  Copyright © 2018 pu yang. All rights reserved.
//

import UIKit

class MemeMeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme:Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.memeImageView.image =  meme.memedImage
    }


}
