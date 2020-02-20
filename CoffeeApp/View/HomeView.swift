//
//  ContentView.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/07.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showingBasket = false
    @ObservedObject var drinkListener = DrinkListener()
    
    var categories: [String : [Drink]] {
        .init(
            grouping: drinkListener.drinks,
            by: { $0.category.rawValue }
        )
    }
    
    var body: some View {
        
        NavigationView {
            
            List(categories.keys.sorted(), id: \String.self) { key in
                DrinkRow(categoryName: "\(key)Drink".uppercased(), drinks: self.categories[key]!)
                .frame(height: 320)
                    .padding(.top)
                    .padding(.bottom)
            }
            .navigationBarTitle(Text("CoffeeApp"))
            .navigationBarItems(leading:
                Button(action: {
                    print("Log Out")
                }, label: {
                    Text("Log Out")
                })
                , trailing:
                Button(action: {
                    self.showingBasket.toggle()
                }, label: {
                    Image("basket")
                })
                    .sheet(isPresented: $showingBasket) {
                        OrderBasketView()
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
