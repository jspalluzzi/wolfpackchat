//
//  WPMessagesViewController.swift
//  wolfpackchat
//
//  Created by xavier on 1/2/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit
import Firebase



class WPMessagesViewController: UITableViewController {
    
    var membersRef: FIRDatabaseReference?
    var member: Member?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        // Do any additional setup after loading the view.
        membersRef?.observe(.value, with: { snap in
            
            if(snap.exists()){
                //Get the user information and save it to CoreData
                print("snap does exist")
                let memberData = snap.value as! Dictionary<String, String>
                //If snap["wolfpackId"] exist then user is in Wolfpack
                //Else load the modal, invite people View MessagesToNoPack
                if(memberData["wolfpackId"] == nil){
                    //self.performSegue(withIdentifier: "MessagesToNoPack", sender: nil)
                }
            }else{
                //Create a user with the given Username and ID
                print("snap does not exist")
                
                let memberInfo = [
                    "name": self.member?.name,
                    "profileImage": self.member?.profileImage,
                    "email": self.member?.email
                ]
                self.membersRef?.setValue(memberInfo)
                
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView Functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesCell", for: indexPath)
        
        
        
        return cell
    }
    
    //MARK: - BAR BUTTONS
    
    @IBAction func didClickAdd(_ sender: UIBarButtonItem) {
        
        self.performSegue(withIdentifier: "MessagesToNewMessage", sender: nil)
        
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
