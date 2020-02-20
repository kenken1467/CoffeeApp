//
//  DrinkListener.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/09.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import Foundation
import Firebase

class DrinkListener: ObservableObject {
    
    @Published var drinks: [Drink] = []
    
    init() {
        downloadDrinks()
    }
    
    func downloadDrinks() {
        
        FirebaseReference(.Menu).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                self.drinks = DrinkListener.drinkFromDictionary(snapshot)
            }
        }
    }
    
    static func drinkFromDictionary(_ snapshot: QuerySnapshot) -> [Drink] {
        
        var allDrinks: [Drink] = []
        
        for snapshot in snapshot.documents {
            let drinkData = snapshot.data()
            allDrinks.append(Drink(id: drinkData[ID] as? String ?? UUID().uuidString, name: drinkData[NAME] as? String ?? "UnKnown", imageName: drinkData[IMAGENAME] as? String ?? "UnKnown", category: Category(rawValue: drinkData[CATEGORY] as? String ?? "cold") ?? .cold, description: drinkData[DESCRIPTION] as? String ?? "Description is missing", price: drinkData[PRICE] as? Int ?? 0))
        }
        return allDrinks
    }
}
