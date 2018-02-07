//
//  MemeTableViewController.swift
//  Meme V1.0
//
//  Created by pu yang on 2/3/18.
//  Copyright © 2018 pu yang. All rights reserved.
//
import Foundation
import UIKit

class MemeTableViewController: UITableViewController {

    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memes = appDelegate.memes
        self.tableView.reloadData()
    }

    // MARK: - Table view data source




    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCellTable")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        tableView.rowHeight = 100
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailedViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeMeDetailViewController") as! MemeMeDetailViewController
        
        detailedViewController.meme = self.memes[(indexPath as NSIndexPath).row ]
        self.navigationController?.pushViewController(detailedViewController, animated: true)

    }

}
