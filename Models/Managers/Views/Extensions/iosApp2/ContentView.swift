//
//  ContentView.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = OrderManager()
    
    var body: some View {
        TabView {
            // Menu Tab (OrderView)
            OrderView()
                .tabItem {
                    Label("Menu", systemImage: "cup.and.saucer.fill")
                }
            
            // Saved Orders Tab
            SavedOrdersView()
                .tabItem {
                    Label("Saved", systemImage: "list.bullet.rectangle")
                }
            
            // Coffee Run Timer Tab
            CoffeeRunTimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            
            // Checkout Tab
            CheckoutView()
                .tabItem {
                    Label("Checkout", systemImage: "creditcard.fill")
                }
        }
        .environmentObject(manager) // share data across views
        .accentColor(.timsBrown)   // Tim Hortons theme color
    }
}

#Preview {
    ContentView().environmentObject(OrderManager())
}

