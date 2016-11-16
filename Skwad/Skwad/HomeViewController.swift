//
//  HomeViewController.swift
//  Skwad
//
//  Created by Corey Smith on 10/29/16.
//  Copyright © 2016 Corey Smith. All rights reserved.
//

import UIKit
import CoreLocation

let myBrain = SkwadBrain()

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let locationManager = CLLocationManager()
    
    
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myBrain.addStupidPack()
        
        myBrain.getPacks()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row != 0{
            return self.view.frame.size.width * (50.0/120.0)
        }else{
            return self.view.frame.size.width * (50.0/120.0)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBrain.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! PostTableViewCell
        
        cell.body.text = myBrain.posts[indexPath.row].text
        
        return cell
        
        
    }
    
}
