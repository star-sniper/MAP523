//
//  ViewController.swift
//  Lab8
//
//  Created by Harshit Arora on 2019-07-17.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tbUserId: UITextField!
    @IBOutlet weak var tbPostID: UITextField!
    
    @IBOutlet weak var tbTitleText: UITextField!
    
    @IBOutlet weak var tfBody: UITextView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

        var userID: Int = 0
        var postId: Int = 0
        var titleRes: String! = ""
        var body: String = ""
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in //
            if error != nil
            {
                
                print(error!)
            }
            else
            {
                if let urlContent = data {
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                
                        userID = jsonResult["userId"] as! Int
                        //print()
                        postId = jsonResult["id"] as! Int
                        
                         titleRes = (jsonResult["title"] as? String)!
                        body = (jsonResult["body"] as? String)!
                        
                        
                        
                        DispatchQueue.main.async { [weak self] in
                            
                            self?.passvals(pid: userID, otherId: postId, title: titleRes, body: body)
                            
                        }
                    } catch {
                        
                        print("JSON Processing Failed")
                        
                    }
                    
                }
            }
        }
        //print("\(titleRes) : title")
       // tbUserId.text = String(userID)
        //tbPostID.text = String(postId)
       
        
        task.resume()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func passvals(pid: Int, otherId: Int, title: String, body: String)
    {
        tbUserId.text = String(pid)
        tbPostID.text = String(otherId)
        tbTitleText.text = String(title)
        tfBody.text = String(body)
    }
}


