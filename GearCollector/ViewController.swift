//
//  ViewController.swift
//  GearCollector
//
//  Created by Robin Tan on 12/4/17.
//  Copyright © 2017 Robin Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gears : [Gear] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            gears = try context.fetch(Gear.fetchRequest())
            tableView.reloadData()
        } catch {
            print("something went wrong fetching coreData")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gears.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let gear = gears[indexPath.row]
        cell.textLabel?.text = gear.descriptor
        cell.imageView?.image = UIImage(data: gear.image as! Data)
        return cell
    }
    
}

