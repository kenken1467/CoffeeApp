//
//  DrinkDetail.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/19.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import SwiftUI

struct DrinkDetail: View {
    
    @State private var showingAlert = false
    var drink: Drink
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .bottom) {
                Image(drink.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Rectangle()
                    .frame(height: 80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(drink.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    
                    Spacer()
                }
            }
            .listRowInsets(EdgeInsets())
            
            Text(drink.description)
                .foregroundColor(.primary)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack {
                Spacer()
                OrderButton(showAlert: $showingAlert, drink: drink)
                Spacer()
            }
            .padding(.top, 50)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("買い物カゴに追加しました！"), dismissButton: .default(Text("OK")))
        }
    }
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData.first!)
    }
}

struct OrderButton: View {
    
    @ObservedObject var basketListener = BasketListener()
    @Binding var showAlert: Bool
    var drink: Drink
    
    var body: some View {
        Button(action: {
            self.showAlert.toggle()
            self.addItemToBasket()
        }) {
            Text("Add to basket")
        }
    .frame(width: 200, height: 50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(15)
    }
    
    private func addItemToBasket() {
        
        var orderBasket: OrderBasket!
        
        if self.basketListener.orderBasket != nil {
            orderBasket = self.basketListener.orderBasket
        } else {
            orderBasket = OrderBasket()
            orderBasket.ownerId = "123"
            orderBasket.id = UUID().uuidString
        }
        
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirebase()
        
    }
}
