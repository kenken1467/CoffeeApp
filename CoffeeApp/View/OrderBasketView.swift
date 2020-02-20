//
//  OrderBasketView.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/19.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(self.basketListener.orderBasket?.items ?? []) { drink in
                        HStack {
                            Text(drink.name)
                            Spacer()
                            Text("\(drink.price)円")
                        }
                    }
                    .onDelete { (indexSet) in
                        self.deleteItems(at: indexSet)
                    }
                }
                
                Section {
                    NavigationLink(destination: CheckoutView()) {
                        Text("お支払い画面へ進む")
                    }
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            }
        .navigationBarTitle("注文")
        .listStyle(GroupedListStyle())
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirebase()
    }
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
