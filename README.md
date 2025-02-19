# Bwallet

## Overview
This project is a **crypto portfolio application** that displays a list of crypto assets alongside the amount held and their fiat value. The application also includes a **settings page** where users can select their preferred currency (USD or HKD). The portfolio should update accordingly based on the selected currency.

## Scope
- Display a list of crypto assets in the **Portfolio Page**.
- Show the amount of each asset held and its equivalent fiat value.
- **Settings Page** with a currency picker (USD / HKD).
- Uses **mock data** for assets and currency values (no networking calls needed).
- Implements **reactive programming** using **Combine/RxSwift**.
- Includes **unit testing**

## Implementation Strategy
### Data Handling
The given mock data consists of:
1. A list of assets containing:
   - **Crypto Symbol** (e.g., BTC, ETH)
   - **Amount of assets held**
2. A list of currency exchange rates mapped to each crypto symbol.

From this data, we define **three key API calls**:
- Fetch all **crypto asset information**.
- Fetch **currency exchange rates** (USD / HKD).
- Map both datasets into a single output for the **portfolio display**.

### Architecture
This project follows **Clean Architecture** principles:
- **Domain Module**: Contains all entities.
- **Service Module**: Defines the blueprint for dependencies used in the app layer.
- **Dependency Module**: Implements services to fetch currencies and assets.
- **Portfolio Feature Module**: UI layer displaying portfolio data.
- **Settings Feature Module**: UI layer to pick fiat currency.
- **Main App Module**: Acts as a **Coordinator**, handling UI navigation and dependency injection.

### Highlights
Unit Test
- 95% coverage

To simulate a real production scenario, I have also created an **API client**:
- Supports both **Live** and **Preview** environments. (**Live** is not implemented, out of scope)
- Uses **Preview Mode** for mock data.
- The dependency interacts with this API client as if it's making actual network calls.

## Tech Stack
- **Swift 5.9 / Combine**.
- **SwiftUI** for UI components.
- **XCTest/Swift Testing** for unit testing.

Made with ❤️ by Jun
