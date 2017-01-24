//
//  NoPackViewController.swift
//  wolfpackchat
//
//  Created by xavier on 1/11/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class NoPackViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var friendCodeTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var popUpMessageView: UIView!
    
    
    //MARK: - Application Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Button Actions
    
    @IBAction func didPressJoinBtn(_ sender: UIButton) {
        
        //Validate the Text Field
        if let text = self.friendCodeTextField.text{
            if(!text.isEmpty){
                
                //Look-up the user
                
                //Handle call-back:
                //Group users together
                
                
            }
        }
    }
    
    //MARK: - Firebase methods and calls
    
    func getUserIdFromEmail(email: String){
        
        membersRef.queryOrdered(byChild: "email").queryStarting(atValue: email).queryEnding(atValue: email)
            .observeSingleEvent(of: .value, with: {snap in
                print(snap)
            })
    }
    
    func checkIfUserInPack(){
        
        //If user has a valid wolfpackID
        
    }
    
    func getWolfpackData(){
        
        //Check to see if there is a wolfpack with that ID
        //If so, get that data
        
    }
    
    func addPackIdToMember(){
        
        //add the wolfpackID of your friends, to your wolfpackID also
        
    }
    
    func addUserIdToPack(){
        
        //Add your ID to the wolfpackThread
        
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



extension NoPackViewController: UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        
    }
    
}
