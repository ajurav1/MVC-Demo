//
//  ViewController.swift
//  MachineTest
//
//  Created by Ajay Walia  on 25/04/18.
//  Copyright © 2018 mac min . All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {
    @IBOutlet weak var tableData: UITableView!
    var itemArry = [String](){
        didSet{
            DispatchQueue.main.async {
                self.tableData.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension VideoListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = itemArry[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

