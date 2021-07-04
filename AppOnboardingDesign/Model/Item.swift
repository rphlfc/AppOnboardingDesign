//
//  Item.swift
//  AppOnboardingDesign
//
//  Created by Raphael Cerqueira on 03/07/21.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID().uuidString
    let backgroundColor: Color
    let image: String
    let title: String
    let subtitle: String
}

let data = [
    Item(backgroundColor: Color("color1"), image: "image1", title: "Get inspired", subtitle: "Don't know what to eat? Take a picture, we'll suggest things to cook with your ingredients."),
    Item(backgroundColor: Color("color2"), image: "image2", title: "Easy & healthy", subtitle: "Find thousands of easy and healthy recipes so you save time and eat better."),
    Item(backgroundColor: Color("color3"), image: "image3", title: "Save your favorites", subtitle: "Save your favorite recipes and get reminders to buy the ingredients to cook them.")
]
