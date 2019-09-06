//
//  ViewController.swift
//  Lab9
//
//  Created by Harshit Arora on 2019-08-06.
//  Copyright © 2019 Harshit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tblView: UITableView!
     let cellTableIdentifier = "CellTableIdentifier"
    let phoneBook = [
        ["First Name" : "Harry", "Last Name" : "Austin", "Contact" : "999 888 6543", "Image" : "Aang"],
        ["First Name" : "Joseph", "Last Name" : "Silver", "Contact" : "888 777 6543", "Image" : "Toph"],
        ["First Name" : "Grace", "Last Name" : "Wong", "Contact" : "777 666 6543", "Image" : "Katara"],
        ["First Name" : "Bryanna", "Last Name" : "Kilroy", "Contact" : "555 444 6543", "Image" : "Zuko"]
    ]
    let bgColor = [UIColor.blue, UIColor.yellow, UIColor.orange, UIColor.brown ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellTableIdentifier, for: indexPath)
            as! PhonebookCell
        let rowData = phoneBook[indexPath.row]
        cell.fname = rowData["First Name"]!
        cell.lname = rowData["Last Name"]!
        cell.contact = rowData["Contact"]!
        cell.imageView?.image = UIImage(named: rowData["Image"]!)
        cell.backgroundColor = bgColor.randomElement()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.register(PhonebookCell.self,
                           forCellReuseIdentifier: cellTableIdentifier)
        // Do any additional setup after loading the view.
    }


}
//The following class creates a custom-made cell that has been used in ViewController at top
class PhonebookCell: UITableViewCell {
    
    //Property observers observe and respond to changes in a property’s value. Property observers are called everytime a property’s value is set, even if the new value is the same as the property’s current value.
    //You have the option to define either or both of these observers on a property:
    //willSet is called just before the value is stored.
    //didSet is called immediately after the new value is stored.
    
    var fname: String = "" {
        didSet {
            fnameLable.text = fname
        }
    }
  var lname: String = "" {
        didSet {
            
            lnameLabel.text = lname
            
        }
    }
    var contact: String = "" {
        didSet {
            
            cntLabel.text = contact
            
        }
    }
    /*
    var imageSet : UIImage
    {
        didSet
        {
           UIImage.init()
        }
    }
    */
    var fnameLable: UILabel!
    var lnameLabel: UILabel!
    var cntLabel: UILabel!
 //   var imgLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let fnameRect = CGRect(x: 180, y: 5, width: 70, height: 15)
        let fnameMarker = UILabel(frame: fnameRect)
        fnameMarker.textAlignment = NSTextAlignment.right
        fnameMarker.text = "First Name:"
        fnameMarker.font = UIFont.boldSystemFont(ofSize: 12)
        contentView.addSubview(fnameMarker)
        
        let lnameRect = CGRect(x: 180, y: 26, width: 70, height: 15)
        let lnameMarker = UILabel(frame: lnameRect)
        lnameMarker.textAlignment = NSTextAlignment.right
        lnameMarker.text = "Last Name:"
        lnameMarker.font = UIFont.boldSystemFont(ofSize: 12)
        contentView.addSubview(lnameMarker)
      
        let cntRect = CGRect(x: 180, y: 47, width: 70, height: 15)
        let cntMarker = UILabel(frame: cntRect)
        cntMarker.textAlignment = NSTextAlignment.right
        cntMarker.text = "Contact:"
        cntMarker.font = UIFont.boldSystemFont(ofSize: 12)
        contentView.addSubview(cntMarker)
        
       
        
        let nameValueRect = CGRect(x: 260, y: 5, width: 200, height: 15)
        fnameLable = UILabel(frame: nameValueRect)
        contentView.addSubview(fnameLable)
        
        let lnameValueRect = CGRect(x: 260, y: 26, width: 200, height: 15)
        lnameLabel = UILabel(frame: lnameValueRect)
        contentView.addSubview(lnameLabel)
        
        let cntValRect = CGRect(x: 260, y: 47, width: 200, height: 15)
        cntLabel = UILabel(frame: cntValRect)
        contentView.addSubview(cntLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

