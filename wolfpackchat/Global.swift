//
//  Global.swift
//  wolfpackchat
//
//  Created by xavier on 1/4/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation
import Firebase

let membersRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Members")

let wolfpackRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Wolfpack")

let threadsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Threads")

