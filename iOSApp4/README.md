# iOSApp4 - Massage Clinic Prototype (Assignment 8)

A progressive SwiftUI application designed for a Massage Therapy Clinic, featuring persistent data storage, modular view components, interactive UI actions, and advanced app state management.

---

## 🚀 Key Features

### 🔹 Assignment 7 Features (Core Architecture)
1. **Advanced NavigationStack Flow**: Handled type-safe dynamic detail navigation via `.navigationDestination(for:)` for `MassageService` entity.
2. **Dynamic Forms & Native Input Components**: Integrated validated `Form` fields alongside customized keyboard mappings (`.phonePad`) for customer profiles.
3. **Custom Global Environment Context Types**: Leveraged dependency injection via `EnvironmentKey` to propagate theme styles globally across view trees.
4. **Observable Object Graph Injections**: Propagated active cross-view session states utilizing `@EnvironmentObject` wrappers for centralized appointment logging tracking.
5. **Asynchronous Transferable Image Stream Loading**: Utilized `PhotosUI`'s `PhotosPicker` coupled with `.task` async hooks to process raw system photopicker streams gracefully.
6. **Encapsulated View Modifier Layout Hierarchies**: Isolated structural style elements like gradient fills and custom dynamic padding layouts neatly into reusable modifiers.

### 🆕 Assignment 8 Enhancements (Refactoring & Persistence)
7. **Structured Data Modeling (`Codable` & `Identifiable`)**: Converted data structures (`Appointment`) to conform to `Codable` and `Identifiable` protocols for safe encoding and decoding.
8. **Local Data Persistence (`UserDefaults`)**: Integrated JSON encoding and decoding pipeline to automatically save and retrieve user appointments across app launches.
9. **Component Architecture Refactoring**: Modularized complex monolithic views into decoupled, maintainable view components (`ServiceRowView`, `ServiceDetailView`, `AppointmentFormView`, `GalleryAndSettingsView`).
10. **Interactive Search Capability**: Integrated `.searchable()` query modifier within the navigation hierarchy to filter through available clinic services dynamically.
11. **Contextual UI Actions**: Enhanced user interaction by adding `.swipeActions` for deleting booked appointments and `.contextMenu` for quick service options.
12. **Native Content Sharing (`ShareLink`)**: Incorporated iOS native `ShareLink` capabilities allowing users to share clinic service information via system sheet integrations.

---

## 🛠️ Project Structure

* **`ContentView.swift`**: Primary layout containing TabView, search bar, and main navigation stack.
* **`ClinicManager.swift`**: Core `@ObservableObject` managing app state, local JSON persistence (`UserDefaults`), and search filtering logic.
* **`Appointment.swift`**: Structured data models conforming to `Identifiable` and `Codable`.
* **`ServiceRowView.swift` / `ServiceDetailView.swift`**: Modular views handling service listings and detailed views.
* **`AppointmentFormView.swift`**: Form interface for inputting and booking new appointments.
* **`GalleryAndSettingsView.swift`**: Photo picker implementation and app theme configuration.
* **`Theme.swift`**: Environment-driven visual styling configurations.
* **`AIReflection.md`**: Reflection document detailing AI assistance during refactoring and architecture updates.












# iOSApp4 - Massage Clinic Prototype (Assignment 7)

A progressive SwiftUI prototype app designed for a Massage Therapy Clinic layout experimenting with advanced patterns from the SwiftUI Cookbook.

## Implemented Cookbook Features:
1. **Advanced NavigationStack Flow**: Handled type-safe dynamic detail navigation via `.navigationDestination(for:)` for `MassageService` entity.
2. **Dynamic Forms & Native Input Components**: Integrated validated `Form` fields alongside customized keyboard mappings (`.phonePad`) for customer profiles.
3. **Custom Global Environment Context Types**: Leveraged dependency injection via `EnvironmentKey` to propagate theme styles (`.relaxingTeal` / `.classicDark`) globally across view trees.
4. **Observable Object Graph Injections**: Propagated active cross-view session states utilizing `@EnvironmentObject` wrappers for centralized appointment logging tracking.
5. **Asynchronous Transferable Image Stream Loading**: Utilized `PhotosUI`'s `PhotosPicker` coupled with `.task` async hooks to process raw system photopicker streams gracefully.
6. **Encapsulated View Modifier Layout Hierarchies**: Isolated structural style elements like gradient fills and custom dynamic padding layouts neatly into re-usable structured structural modifiers.

