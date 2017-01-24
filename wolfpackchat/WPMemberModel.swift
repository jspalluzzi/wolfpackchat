//
//  WPMember.swift
//  wolfpackchat
//
//  Created by xavier on 1/4/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation
import Firebase

//A general model not of the Member object, not specific to any View
//This structure will be filled with data from the WPMemberNetwork object

//The memberModel should communicate with the member network to see if there are any updates
//This object should communicate with CoreData when there are updates


internal class Member{
    
    internal let id: String
    internal let name: String
    internal let profileImage: String?
    internal let email: String
    
    init(id: String, name: String, email: String, profileImage: String = ""){
        self.id = id
        self.name = name
        self.email = email
        self.profileImage = profileImage
    }

}

struct WPMember {
    
    let key: String?
    var name: String?
    let ref: FIRDatabaseReference?
    var completed: Bool
    
    init(name: String, completed: Bool, key: String = "") {
        self.key = key
        self.name = name
        self.completed = completed
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as? String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name!,
            "completed": completed
        ]
    }
    
}



extension Member{
    
    //Check if User ID is in MembersDB
    func memberFor(id: String) -> Bool{
        var value = false
        membersRef.observe(.value, with: { snapshot in
            let member = WPMember(snapshot: snapshot)
            
            if member.name != nil{
                value = true
            }
            
            })
        
        return value
    }

    //Add New Member to MembersDB
    func addMember(){
        let newMemberRef = membersRef.child("")
        let memberInfo = [
            "name": name,
            "profileImage": profileImage
        ]
        newMemberRef.setValue(memberInfo)
    }
    
    
}
