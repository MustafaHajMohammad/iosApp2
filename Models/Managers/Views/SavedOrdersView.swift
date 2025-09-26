//
//  SavedOrdersView.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//


import SwiftUI

struct SavedOrdersView: View {
    @EnvironmentObject var manager: OrderManager
    @State private var goToCheckout = false   // ✅ state to trigger navigation
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(manager.orders) { order in
                    VStack(alignment: .leading) {
                        Text("\(order.quantity)x \(order.drinkSize) \(order.drinkType)")
                            .font(.headline)
                        if !order.addOns.isEmpty {
                            Text("Add-ons: \(order.addOns.joined(separator: ", "))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                goToCheckout = true   // ✅ just trigger navigation
                            }) {
                                Text("Add to Checkout")
                                    .padding(8)
                                    .background(Color.timsBrown)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Button(action: {
                                if let index = manager.orders.firstIndex(where: { $0.id == order.id }) {
                                    manager.orders.remove(at: index)
                                }
                            }) {
                                Text("Delete")
                                    .padding(8)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Saved Orders")
            
            // ✅ Navigation to CheckoutView without duplication
            .navigationDestination(isPresented: $goToCheckout) {
                CheckoutView()
                    .environmentObject(manager)
            }
        }
    }
}

#Preview {
    SavedOrdersView().environmentObject(OrderManager())
}

