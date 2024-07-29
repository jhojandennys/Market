//
//  FirebaseCollectionReference.swift
//  Market
//
//  Created by David Kababyan on 14/07/2019.
//  Copyright © 2019 David Kababyan. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}

