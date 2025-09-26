//
//  ReceiptView.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//

import SwiftUI

struct ReceiptView: View {
    var orders: [OrderItem]
    var subtotal: Double
    var tax: Double
    var total: Double
    var paymentMethod: String
    
    // Get a friendly name for the thank-you message
    private var thankYouDrinkName: String {
        if orders.isEmpty {
            return "order"
        }
        if orders.count == 1 {
            return orders.first?.drinkType.lowercased() ?? "drink"
        }
        return "drinks"
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Header
                VStack {
                    Image(systemName: "creditcard.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.timsBrown)
                    Text("Order Receipt")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                
                // Order Summary
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(orders) { order in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(order.quantity)x \(order.drinkSize) \(order.drinkType)")
                                .font(.headline)
                            
                            if !order.addOns.isEmpty {
                                Text("Add-ons: \(order.addOns.joined(separator: ", "))")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Totals
                VStack(alignment: .leading, spacing: 8) {
                    Text("Subtotal: $\(String(format: "%.2f", subtotal))")
                    Text("Tax (13%): $\(String(format: "%.2f", tax))")
                    Text("Total: $\(String(format: "%.2f", total))")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Payment Info
                Text("Paid with: \(paymentMethod)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Date: \(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Thank You Message (Dynamic)
                VStack(spacing: 8) {
                    Text("💖 Thank you for your order!")
                        .font(.headline)
                        .foregroundColor(.timsBrown)
                    Text("Your \(thankYouDrinkName) will be delivered soon.\nSit back, relax, and enjoy your drink!")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Back to Menu Button
                NavigationLink(destination: ContentView().environmentObject(OrderManager())) {
                    Text("Back to Menu")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.timsBrown)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ReceiptView(
        orders: [
            OrderItem(drinkType: "Latte", drinkSize: "Large", addOns: ["Milk", "Sugar"], quantity: 2)
        ],
        subtotal: 6.00,
        tax: 0.78,
        total: 6.78,
        paymentMethod: "Debit Card"
    )
}
