//
//  Drink.swift
//  CoffeeApp
//
//  Created by hayashi kenji on 2020/02/08.
//  Copyright © 2020 hayashi kenji. All rights reserved.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable, Hashable {
    
    case hot
    case cold
    case filter
    
}

struct Drink: Identifiable, Hashable {
    
    var id: String
    var name: String
    var imageName: String
    var category: Category
    var description: String
    var price: Int
    
}

func drinkDictionaryFrom(drink: Drink) -> [String : Any] {
    
    return NSDictionary(objects: [drink.id,
                                  drink.name,
                                  drink.imageName,
                                  drink.category.rawValue,
                                  drink.description,
                                  drink.price
                                ],
                        forKeys: [
                                  ID as NSCopying,
                                  NAME as NSCopying,
                                  IMAGENAME as NSCopying,
                                  CATEGORY as NSCopying,
                                  DESCRIPTION as NSCopying,
                                  PRICE as NSCopying
    ]) as! [String : Any]
}

func createMenu() {
    for drink in drinkData {
        FirebaseReference(.Menu).addDocument(data: drinkDictionaryFrom(drink: drink))
    }
}



let drinkData = [
    
    //HOT
    Drink(id: UUID().uuidString, name: "エスプレッソ", imageName: "espresso", category: Category.hot, description: "エスプレッソはエスプレッソマシンでコーヒー豆に高い圧力をかけ、一気に淹れる抽出方法です。ドリップコーヒーと比べると量は少ないですが、その分コーヒー豆の成分がぎゅっと凝縮された深い味わいと香りが楽しめます。", price: 310),
    
    Drink(id: UUID().uuidString, name: "アメリカーノ", imageName: "americano", category: Category.hot, description: "アメリカーノコーヒーはエスプレッソにお湯を注いだスッキリとしたのどごしのコーヒーです。エスプレッソに比べるとコーヒーの濃さが控えめになっているのでドリップコーヒーが好きな人にオススメです。", price: 320),
    
    Drink(id: UUID().uuidString, name: "カプチーノ", imageName: "cappuccino", category: Category.hot, description: "カプチーノはイタリアで生まれたもので、エスプレッソに温めたスチームミルクとクリーム状に泡だてたフォームミルクを加えたものです。ふんわりと滑らかな舌触りのフォームミルクを楽しめるカプチーノです。", price: 340),
    
    Drink(id: UUID().uuidString, name: "カフェラテ", imageName: "latte", category: Category.hot, description: "ラテはエスプレッソに温めたスチームミルクを加えたものでまた発祥もイタリアなのでカプチーノと似ております。ラテの方がカプチーノと比べてミルク含有量が多いため、まろやかな風味を味わうことができます。", price: 340),
        
                    
    //FILTER
    Drink(id: UUID().uuidString, name: "ドリップコーヒー", imageName: "filter coffee", category: Category.filter, description: "コーヒー豆の粉にお湯をかけ、お湯の重さで圧力をかけながら濾過するようにしてコーヒー豆の成分を抽出するコーヒーのです。ドリップすることによりコーヒー豆の内部にお湯を浸透させ、豆に含まれているエキスをしっかり抽出させるのが特徴です。", price: 340),
    
    Drink(id: UUID().uuidString, name: "デカフェコーヒー", imageName: "decaf", category: Category.filter, description: "通常のコーヒーにはカフェインが含まれていますが、このデカフェコーヒーはカフェインの量を減らしたものとなっております。なのでカフェインをあまり摂取されたくない方や妊婦さんなどにオススメです。", price: 360),

    Drink(id: UUID().uuidString, name: "コールドブリュー", imageName: "cold brew", category: Category.filter, description: "一般的なアイスコーヒーは温かいドリップコーヒーに氷を入れ冷ましてす作りますが、コールドブリューは挽いたコーヒー豆を冷やした水の中に入れ、12時間〜24時間冷やしたものとなっております。豊かな味わいと滑らかな口当たりを楽しむことができます。", price: 310),

    Drink(id: UUID().uuidString, name: "コールドブリューラテ", imageName: "brew latte", category: Category.filter, description: "冷水でコーヒー豆をじっくり抽出したコールドブリューをつかうことにより苦味や雑味が抑えられています。それによってコーヒー本来の味と香りが生き、澄み切った味わいが楽しめます。", price: 390),

    
    
    //COLD
    Drink(id: UUID().uuidString, name: "フラッペ", imageName: "frappe", category: Category.cold, description: "フラッペコーヒーはギリシャ発祥であり、コーヒーに水、氷、砂糖、お好みでミルクを入れ、それをシェーカーで振って作ります。コーヒーにシャッキとした食感が加わり、暑い夏にもってこいの一品です。", price: 450),
    
    Drink(id: UUID().uuidString, name: "アイスカプチーノ", imageName: "freddo espresso", category: Category.cold, description: "濃厚なエスプレッソとクリーミーで甘味のあるフォームミルクのコンビネーションが絶妙となっている一杯となっております。キメの細かく柔らかいクリームを使用していますので滑らかな仕上がりとなっております。", price: 410),
    
    Drink(id: UUID().uuidString, name: "アイスコーヒー", imageName: "ice americano", category: Category.cold, description: "こちらのアイスコーヒーはほんのりとした酸味と重すぎない苦味になっていますのでスッキリとした喉越しとなっております。", price: 320),
    
    Drink(id: UUID().uuidString, name: "アイスカフェラテ", imageName: "iced latte", category: Category.cold, description: "しっかりとしたミルク感の中にエスプレッソコーヒーのほろ苦さが香る絶妙なバランスとなっているアイスカフェラテとなっております。", price: 380)
    
]


