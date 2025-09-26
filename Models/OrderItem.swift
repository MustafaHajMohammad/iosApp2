//
//  OrderItem.swift
//  iosApp2
//
//  Created by Satoof Haj  on 2025-09-26.
//

import Foundation

struct OrderItem: Identifiable, Codable {
    var id = UUID()
    var drinkType: String
    var drinkSize: String
    var addOns: [String]
    var quantity: Int
    
    // Calculate price for this item
    var price: Double {
        var basePrice: Double
        
        switch drinkType {
        case "Coffee": basePrice = 2.0
        case "Tea": basePrice = 1.5
        case "Latte": basePrice = 3.5
        default: basePrice = 2.0
        }
        
        // Adjust by size
        switch drinkSize {
        case "Medium": basePrice += 0.5
        case "Large": basePrice += 1.0
        default: break
        }
        
        // Add-ons ($0.25 each)
        basePrice += Double(addOns.count) * 0.25
        
        return basePrice * Double(quantity)
    }
}

