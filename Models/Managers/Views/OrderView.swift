//
//  OrderView.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var manager: OrderManager

    @State private var drinkType = ""
    @State private var drinkSize = ""
    @State private var addOns: [String] = []
    @State private var quantity = 1
    @State private var showConfirmation = false

    let drinkTypes = ["Coffee", "Tea", "Latte"]
    let drinkSizes = ["Small", "Medium", "Large"]
    let addOnOptions = ["Milk", "Cream", "Sugar", "Black"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Drink Type")) {
                    Picker("Select", selection: $drinkType) {
                        ForEach(drinkTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                }

                Section(header: Text("Size")) {
                    Picker("Select", selection: $drinkSize) {
                        ForEach(drinkSizes, id: \.self) { size in
                            Text(size)
                        }
                    }
                }

                Section(header: Text("Add-ons")) {
                    ForEach(addOnOptions, id: \.self) { option in
                        Toggle(option, isOn: Binding(
                            get: { addOns.contains(option) },
                            set: { isOn in
                                if isOn {
                                    addOns.append(option)
                                } else {
                                    addOns.removeAll { $0 == option }
                                }
                            }
                        ))
                    }
                }

                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)

                Button("Add to Order") {
                    let newOrder = OrderItem(
                        drinkType: drinkType,
                        drinkSize: drinkSize,
                        addOns: addOns,
                        quantity: quantity
                    )
                    manager.addOrder(newOrder)

                    // Show confirmation
                    showConfirmation = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showConfirmation = false
                    }

                    // Reset form
                    drinkType = ""
                    drinkSize = ""
                    addOns = []
                    quantity = 1
                }
                .buttonStyle(.borderedProminent)
                .tint(.timsBrown)

                if showConfirmation {
                    Text("✅ Order has been added!")
                        .foregroundColor(.green)
                        .font(.subheadline)
                        .transition(.opacity)
                }
            }
            .navigationTitle("New Order")
        }
    }
}

#Preview {
    OrderView().environmentObject(OrderManager())
}


