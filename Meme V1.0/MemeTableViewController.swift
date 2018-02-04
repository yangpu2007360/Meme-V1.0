//
//  MemeTableViewController.swift
//  Meme V1.0
//
//  Created by pu yang on 2/3/18.
//  Copyright © 2018 pu yang. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    var memes = [Meme]()

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView!.reloadData()
    }

    // MARK: - Table view data source




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeViewCell") as! UITableViewCell
        let data = memes[indexPath.row]
        
        cell.imageView?.image = data.memedImage
        cell.textLabel?.text = data.topText
        
        return cell
    }
    
    



}
