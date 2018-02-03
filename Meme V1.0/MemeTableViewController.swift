//
//  MemeTableViewController.swift
//  Meme V1.0
//
//  Created by pu yang on 2/3/18.
//  Copyright © 2018 pu yang. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    memes = appDelegate.memes

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the image
        cell.imageView?.image = meme.memedImage
        
        return cell
    }


}
