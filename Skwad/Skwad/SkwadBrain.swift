//
//  skwadBrain.swift
//  Skwad
//
//  Created by Corey Smith on 10/31/16.
//  Copyright © 2016 Corey Smith. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

import AVFoundation
import GameKit
import SystemConfiguration

import Firebase
import FirebaseDatabase



class SkwadBrain{
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    
    var locManager = CLLocationManager()
    var currentLocation = CLLocation()
    
    var joinedPacks = [packStruct]()
    var posts = [postStruct]()
    var packs = [packStruct]()
    
    var currentPackKey = 0
    
    func getLocation() -> [Double]{
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            currentLocation = locManager.location!
            
            return[currentLocation.coordinate.longitude,currentLocation.coordinate.latitude]
            
        }
        
        return[0,0]
        
        
    }
    
    
    
    func updatePosts(){
        ref = FIRDatabase.database().reference()
        
        var location = getLocation()
        location[0] = location[0]+180
        location[1] = location[1]+90
        
        let shortLocations = ["\(Int(floor(location[0]*10)))\(Int(floor(location[1]*10)))",
            "\(Int(ceil(location[0]*10)))\(Int(floor(location[1]*10)))",
            "\(Int(floor(location[0]*10)))\(Int(ceil(location[1]*10)))",
            "\(Int(ceil(location[0]*10)))\(Int(ceil(location[1]*10)))"]
        
        print("SHORTLOCATION: \(shortLocations)")
        
        let postsWipe = [postStruct]()
        posts = postsWipe
        
        if packs.count > 0{
            
                ref.child("posts").child(packs[currentPackKey].KEY).queryOrderedByKey().observe(.childAdded, with: {
                snapshot in
                
                let snapValues = snapshot.value as! Dictionary< String, AnyObject>
                
                print("a")
                
                let pack = snapValues["pack"] as! String
                let like = snapValues["like"] as! String
                let text = snapValues["text"] as! String
                let time = snapValues["time"] as! String
                
                self.posts.insert(postStruct(pack: pack, like: like, text: text,time: time) , at: 0)
                //self.tableView.reloadData()
                
                
                
            })
            
        }
        
    }
    
    func getPacks(){
        ref = FIRDatabase.database().reference()
        
        var location = getLocation()
        location[0] = location[0]+180
        location[1] = location[1]+90
        
        print("LONG: \(location)")
        print()
        print()
        
        print()
        
        
        let shortLocations = ["\(Int(floor(location[0]*10)))\(Int(floor(location[1]*10)))",
            "\(Int(ceil(location[0]*10)))\(Int(floor(location[1]*10)))",
            "\(Int(floor(location[0]*10)))\(Int(ceil(location[1]*10)))",
            "\(Int(ceil(location[0]*10)))\(Int(ceil(location[1]*10)))"]
        
        print("SHORTLOCATION: \(shortLocations)")
        
        let packsWipe = [packStruct]()
        packs = packsWipe
        
        for location in shortLocations{
            
            ref.child("packs").child(location).queryOrderedByKey().observe(.childAdded, with: {
                snapshot in
                
                let snapValues = snapshot.value as! Dictionary< String, AnyObject>
                
                print("a")
                
                let name = snapValues["name"] as! String
                let lat = snapValues["lat"] as! String
                let lon = snapValues["lon"] as! String
                let time = snapValues["time"] as! String
                let desc = snapValues["desc"] as! String
                let KEY = snapValues["KEY"] as! String
                
                self.packs.insert(packStruct(name: name, lon: lon, lat: lat,time: time, desc: desc, KEY: KEY) , at: 0)
                //self.tableView.reloadData()
                
                print("COUNT: \(self.packs.count)")
                
                for pack in self.packs{
                    print(pack.name)
                    print(pack.KEY)
                    print(pack.time)
                }
                
            })
        }
        
        
    }
    
    func addPost(body: String){
        ref = FIRDatabase.database().reference()
        
        var mdata = [String:String]()
        mdata["pack"] = "Pizza"
        mdata["like"] = "69"
        mdata["text"] = "eat my ass"
        mdata["time"] = String(Int(NSTimeIntervalSince1970))
        
        print("SHIT OUT MY ASS")
        print(self.packs.count)
        
        if packs.count > 0{
        
        ref.child("posts").child(packs[currentPackKey].KEY).childByAutoId().setValue(mdata)
        }
        
    }
    
    func addStupidPack(){
        ref = FIRDatabase.database().reference()
        
        var location = getLocation()
        location[0] = (location[0]+180)*10
        location[1] = (location[1]+90)*10
        
        
        var mdata = [String:String]()
        mdata["name"] = "Pizza"
        mdata["lat"] = "034534"
        mdata["lon"] = "34534534"
        mdata["time"] = String(NSTimeIntervalSince1970)
        mdata["desc"] = "do stuff go TRUMP 10 Billion"
        
        let rando = Int(arc4random_uniform(10000000))
        mdata["KEY"] = "\(Int(location[0]))\(Int(location[1]))\(rando)"
        
        
        //let locationInt = [round(location[0]*10000),round(location[1]*10000)]
        
        let locationShort = "\(Int(round(location[0])))\(Int(round(location[1])))"
        
        print("CHOSEN:\(locationShort)")
        
        ref.child("packs").child(locationShort).childByAutoId().setValue(mdata)
        //ref.child(titleOfPack.text!)
    }
    
    init(){
        locManager.requestWhenInUseAuthorization()
        
    }
    
    
    struct postStruct {
        let pack : String!
        let like : String!
        let text : String!
        let time : String!
    }
    
    struct packStruct {
        let name : String!
        let lon : String!
        let lat : String!
        let time : String!
        let desc : String!
        let KEY : String!
    }
}
