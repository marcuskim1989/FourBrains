//
//  FirestoreReferenceManager.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 12/19/22.
//  Copyright © 2022 Marcus Kim. All rights reserved.

import Firebase

struct FirestoreReferenceManager {
    
    static let devEnvironment = "dev"
    static let usersConstant = "users"
    static let testerConstant = "tester"
    static let publicDataConstant = "publicData"
    
    static let db = Firestore.firestore()
    
    
    
    static let devRoot = db
        .collection(devEnvironment)
        .document(devEnvironment)
    
    static let devUsersCollection = db
        .collection(devEnvironment)
        .document(devEnvironment)
        .collection(usersConstant)
    
    static let devTesterDoc = db
        .collection(devEnvironment)
        .document(devEnvironment)
        .collection(usersConstant)
        .document(testerConstant)
    
    static let publicDataCollection = db
        .collection(devEnvironment)
        .document(devEnvironment)
        .collection(usersConstant)
        .document(testerConstant)
        .collection(publicDataConstant)
    
    static let publicDataDocument = db
        .collection(devEnvironment)
        .document(devEnvironment)
        .collection(usersConstant)
        .document(testerConstant)
        .collection(publicDataConstant)
        .document(publicDataConstant)
    
}
