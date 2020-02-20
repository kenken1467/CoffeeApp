//
//  BasketListener.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/19.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import Foundation
import Firebase

class BasketListener: ObservableObject {
    
    @Published var orderBasket: OrderBasket!
    
    init() {
        downloadBasket()
    }
    
    func downloadBasket() {
        FirebaseReference(.Basket).whereField(OWNERID, isEqualTo: "123").addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                
                let basketData = snapshot.documents.first!.data()
                
                getDrinksFromFirestore(withIds: basketData[DRINKIDS] as? [String] ?? []) { (allDrinks) in
                    let basket = OrderBasket()
                    basket.ownerId = basketData[OWNERID] as? String
                    basket.id = basketData[ID] as? String
                    basket.items = allDrinks
                    self.orderBasket = basket
                }
            }
        }
    }
}

func getDrinksFromFirestore(withIds: [String], completion: @escaping (_ drinkArray: [Drink]) -> Void) {
    
    var count = 0
    var drinkArray: [Drink] = []
    
    if withIds.count == 0 {
        completion(drinkArray)
        return
    }
    
    for drinkId in withIds {
        
        FirebaseReference(.Menu).whereField(ID, isEqualTo: drinkId).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                
                let drinkData = snapshot.documents.first!
                
                drinkArray.append(Drink(id: drinkData[ID] as? String ?? UUID().uuidString,
                                        name: drinkData[NAME] as? String ?? "Unknown",
                                        imageName: drinkData[IMAGENAME] as? String ?? "Unknown",
                                        category: Category(rawValue: drinkData[CATEGORY] as? String ?? "cold") ?? .cold,
                                        description: drinkData[DESCRIPTION] as? String ?? "Description is missing",
                                        price: drinkData[PRICE] as? Int ?? 0))
                count += 1
            } else {
                print("have no drink")
                completion(drinkArray)
            }
            
            if count == withIds.count {
                completion(drinkArray)
            }
        }
    }
}

