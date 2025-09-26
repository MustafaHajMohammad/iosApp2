//
//  CheckoutView.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var manager: OrderManager
    @State private var selectedPayment = "Credit Card"
    @State private var showReceipt = false
    @State private var showErrorAlert = false   // 🚨 for no orders

    // Last checkout summary
    @State private var lastOrders: [OrderItem] = []
    @State private var lastSubtotal: Double = 0.0
    @State private var lastTax: Double = 0.0
    @State private var lastTotal: Double = 0.0

    let paymentMethods = ["Credit Card", "Debit Card", "Cash"]

    // ✅ Subtotal now uses quantity properly
    var subtotal: Double {
        manager.orders.reduce(0) { $0 + (Double($1.quantity) * 3.0) }
    }

    var tax: Double {
        subtotal * 0.13
    }

    var total: Double {
        subtotal + tax
    }

    var body: some View {
        NavigationStack {
            VStack {
                if manager.orders.isEmpty {
                    Text("No orders yet ☕️")
                        .font(.headline)
                        .padding()
                } else {
                    List {
                        ForEach(manager.orders) { order in
                            VStack(alignment: .leading) {
                                Text("\(order.quantity)x \(order.drinkSize) \(order.drinkType)")
                                    .font(.headline)
                                Text("Add-ons: \(order.addOns.joined(separator: ", "))")
                                    .font(.subheadline)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Subtotal: $\(subtotal, specifier: "%.2f")")
                        Text("Tax (13%): $\(tax, specifier: "%.2f")")
                        Text("Total: $\(total, specifier: "%.2f")")
                    }
                    .padding()

                    Picker("Payment Method", selection: $selectedPayment) {
                        ForEach(paymentMethods, id: \.self) { method in
                            Text(method)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    Button(action: completeCheckout) {
                        Text("Complete Checkout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.timsBrown)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationTitle("Checkout")
            .alert("Sorry!", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Cannot proceed — no orders found.")
            }
            .navigationDestination(isPresented: $showReceipt) {
                ReceiptView(
                    orders: lastOrders,
                    subtotal: lastSubtotal,
                    tax: lastTax,
                    total: lastTotal,
                    paymentMethod: selectedPayment
                )
            }
        }
    }

    private func completeCheckout() {
        guard !manager.orders.isEmpty else {
            showErrorAlert = true
            return
        }

        // Save current orders for receipt
        lastOrders = manager.orders
        lastSubtotal = subtotal
        lastTax = tax
        lastTotal = total

        // ✅ Clear the cart after checkout
        manager.clearOrders()

        // ✅ Show receipt
        showReceipt = true
    }
}

#Preview {
    CheckoutView()
        .environmentObject(OrderManager())
}

