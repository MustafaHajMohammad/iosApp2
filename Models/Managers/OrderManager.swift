//
//  OrderManager.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//

import Foundation

class OrderManager: ObservableObject {
    @Published var orders: [OrderItem] = [] {
        didSet {
            saveOrders()
        }
    }
    
    private let saveKey = "savedOrders"
    
    init() {
        loadOrders()
    }
    
    // ✅ Add new order (prevents duplicates)
    func addOrder(_ order: OrderItem) {
        if let index = orders.firstIndex(where: {
            $0.drinkType == order.drinkType &&
            $0.drinkSize == order.drinkSize &&
            $0.addOns.sorted() == order.addOns.sorted()
        }) {
            // If same order exists, just increase the quantity
            orders[index].quantity += order.quantity
        } else {
            // Otherwise, add as a new order
            orders.append(order)
        }
        saveOrders()
    }
    
    // Delete order
    func deleteOrder(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
        saveOrders()
    }
    
    // Clear all orders (checkout complete)
    func clearOrders() {
        orders.removeAll()
        saveOrders()
    }
    
    // Save to UserDefaults
    private func saveOrders() {
        if let encoded = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    // Load from UserDefaults
    private func loadOrders() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([OrderItem].self, from: savedData) {
            self.orders = decoded
        }
    }
}
