//
//  CheckoutView.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/19.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    static let paymentTypes = ["Cash", "Credit Card"]
    @ObservedObject var basketListener = BasketListener()
    @State private var paymentType = 0
    @State private var showingPaymentAlert = false
    
    var totalPrice: Int {
        let total = basketListener.orderBasket.total
        return total
    }
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $paymentType, label: Text("お支払い方法")) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
            }
            
            Section(header: Text("合計 \(totalPrice)").font(.largeTitle)) {
                Button(action: {
                    self.showingPaymentAlert.toggle()
                    self.createOrder()
                    self.emptyBasket()
                }) {
                    Text("注文確認")
                }
            }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
        }
        .navigationBarTitle(Text("お支払い"), displayMode: .inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("注文を確認しました"), message: Text("ありがとうございました！"), dismissButton: .default(Text("OK")))
        }
    }
    
    private func createOrder() {
        
        let order = Order()
        order.amount = totalPrice
        order.id = UUID().uuidString
        order.customerId = "123"
        order.orderItems = self.basketListener.orderBasket.items
        order.saveOrderToFirestore()
        
    }
    
    private func emptyBasket() {
        self.basketListener.orderBasket.emptyBasket()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
