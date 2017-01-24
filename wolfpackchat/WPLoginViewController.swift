//
//  WPLoginViewController.swift
//  wolfpackchat
//
//  Created by xavier on 1/2/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
import Firebase
import GoogleSignIn


class WPLoginViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
    
    let loginToMessages = "LoginToMessages"
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
    //MARK: APPLICATION LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //FIREBASE CHECK AUTH
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                
                //saveMemberInDB(user!)
                
                self.performSegue(withIdentifier: self.loginToMessages, sender: user)
            }
        }
        
        //FACEBOOK LOGIN BTN
        let loginBtn = LoginButton(readPermissions: [.publicProfile, .email])
        loginBtn.delegate = self
        loginBtn.center = view.center
        self.view.addSubview(loginBtn)
        
        //GOOGLE LOGIN BTN
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: FACEBOOK LOGIN FUNCTIONS
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult){
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("User cancelled login.")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged in!")
            print(grantedPermissions)
            print(declinedPermissions)
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.userId!)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                // ...
                if let error = error {
                    print(error)
                    return
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        
    }
    
    //MARK: GOOGLE LOGIN FUNCTIONS
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: sourceApplication,
                                                 annotation: annotation)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let messagesVc = segue.destination as! WPMessagesViewController
        let fireUser = sender as! FIRUser
        
        messagesVc.membersRef = membersRef.child(fireUser.uid)
        let member = Member(id: fireUser.uid, name: fireUser.displayName!, email: fireUser.email!)
        messagesVc.member = member
    }

}
