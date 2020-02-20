//
//  Order.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/19.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import Foundation

class Order: Identifiable {
    
    var id: String!
    var customerId: String!
    var orderItems: [Drink] = []
    var amount: Int!
    
    func saveOrderToFirestore() {
        
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)) { error in
            if error != nil {
                print("error saving order to firestore: ", error!.localizedDescription)
            }
        }
    }
}

func orderDictionaryFrom(_ order: Order) -> [String : Any] {
    
    var allDrinksIds: [String] = []
    
    for drink in order.orderItems {
        allDrinksIds.append(drink.id)
    }
    
    return NSDictionary(objects: [order.id,
                                  order.customerId,
                                  allDrinksIds,
                                  order.amount
                                ],
                        forKeys: [ID as NSCopying,
                                  CUSTOMERID as NSCopying,
                                  DRINKIDS as NSCopying,
                                  AMOUNT as NSCopying
    ]) as! [String : Any]
    
}
