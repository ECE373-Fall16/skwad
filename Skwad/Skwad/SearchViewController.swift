//
//  SearchViewController.swift
//  Skwad
//
//  Created by Corey Smith on 10/29/16.
//  Copyright © 2016 Corey Smith. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        myBrain.addPost(body: "hello winnie pooh")
        myBrain.addPost(body: "I eat poopoo")
        
        myBrain.updatePosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
