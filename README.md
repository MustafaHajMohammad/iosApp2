# iosApp2 – Coffee Ordering App ☕️  

## 📱 Overview  
This is an iOS coffee ordering application built with **SwiftUI** and designed as part of Assignment 2.  
It simulates a real-world coffee ordering experience with full functionality:  

- 📝 Create new coffee/tea/latte orders  
- 💾 Save orders for later  
- ⏱ Coffee run timer for group orders  
- 🛒 Checkout with subtotal, tax, and total calculation  
- 📄 Receipt view with confirmation message  
- 🎨 Landing screen with background image, fade-in animation, and clean UI  

---

## ⚙️ Features  
- **LandingView**: Welcome screen with background and “Go to Menu” button  
- **ContentView**: Tab bar navigation (Menu, Saved, Timer, Checkout)  
- **OrderView**: Create new drinks with options (size, add-ons, quantity)  
- **SavedOrdersView**: View and reuse previously saved orders  
- **CheckoutView**: Finalize order, prevent empty checkout, calculate totals  
- **ReceiptView**: Thank you message + dynamic drink type message (coffee, tea, latte)  

---

## 🛠 Technical Details  
- Built with **SwiftUI**  
- Navigation implemented using **NavigationStack** (iOS 16+)  
- State management with **@StateObject / @EnvironmentObject**  
- Persistent storage with **UserDefaults** for saved orders  

---

## 📸 Screenshots  
- Landing Page with coffee background  
- Menu / Order form  
- Checkout + Receipt  

---

## 📂 Project Structure  
iosApp2
│── Models/
│── Managers/
│── Views/
│── Extensions/
│── Assets.xcassets/
│── iosApp2.xcodeproj



---

## 👨‍💻 Author  
Mustafa Haj Mohammad  

---

## 📝 Assignment Notes  
This project was developed as part of **MWD3A (iOS) – Assignment 2**.  
