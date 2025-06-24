# App_IOS

This project contains a simple SwiftUI application that demonstrates a product catalog with favorites and cart management. The application fetches products from `https://sugary-wool-penguin.glitch.me/products` and displays them in a grid. Users can add items to their favorites list or shopping cart and inspect each product in a detail view.

## Building the project
Open the `PA3.xcodeproj` in Xcode and run the `PA3` scheme. The minimum deployment target is iOS 17. The project uses Swift concurrency (`async/await`) for loading products.

## Main Screens
- **Home**: Grid of products from the web service.
- **Favorites**: Products marked as favorites.
- **Cart**: Products added to the cart with quantity controls and total price summary.

All features are implemented purely in Swift using SwiftUI.
