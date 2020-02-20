//
//  OrderBasket.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/19.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import Foundation
import Firebase

class OrderBasket: Identifiable {
    
    var id: String!
    var ownerId: String!
    var items: [Drink] = []
    
    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }
    
    func add(_ item: Drink) {
        items.append(item)
    }
    
    func remove(_ item: Drink) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    
    func emptyBasket() {
        self.items = []
        saveBasketToFirebase()
    }
    
    func saveBasketToFirebase() {
        FirebaseReference(.Basket).document(self.id).setData(basketDictionnaryFrom(self))
    }
}


func basketDictionnaryFrom(_ basket: OrderBasket) -> [String : Any] {
    
    var allDrinkIds: [String] = []
    
    for drink in basket.items {
        allDrinkIds.append(drink.id)
    }
    
    return NSDictionary(objects: [basket.id,
                                  basket.ownerId,
                                  allDrinkIds
                                ],
                        forKeys: [ID as NSCopying,
                                  OWNERID as NSCopying,
                                  DRINKIDS as NSCopying
                                ]) as! [String : Any]
}
