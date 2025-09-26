//
//  LandingView.swift
//  iosApp2
//
//  Created by Satoof Haj on 2025-09-26.
//

import SwiftUI

struct LandingView: View {
    @State private var fadeIn = false
    
    var body: some View {
        ZStack {
            // Background image
            Image("coffeeBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            // Dark overlay for readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.4), Color.black.opacity(0.2)]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Welcome text
                Text("Welcome to My Coffee")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                    .multilineTextAlignment(.center)
                
                Text("Order your favorite drinks!")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal)
                
                // Go to Menu button
                NavigationLink(destination: ContentView()) {
                    Text("Go to Menu")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.timsBrown)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
            }
            .opacity(fadeIn ? 1 : 0) // Fade-in animation
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    fadeIn = true
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        LandingView()
    }
}

