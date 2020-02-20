//
//  FirebaseReference.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/08.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Menu
    case Order
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
