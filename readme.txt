SmartChef | Flutter Recipe Discovery
SmartChef is a high-performance Flutter mobile application designed for food enthusiasts. It provides a data-rich experience, offering deep insights into every meal, from macronutrient breakdowns to structured culinary instructions.
Features:
 Advanced Nutritional Tracking: Detailed display of Protein, Carbs, and Fat per serving.
 Difficulty : Quick-glance metrics for prep time and cooking complexity.
 Structured Cooking Flow: A clean, non-linear approach to following recipe instructions.
 Smart Categorization: Filter by mealType (Breakfast, Lunch, Dinner, etc.) and custom search tags.
 Favorites Engine: Local persistence for saving user-preferred recipes.
Technical Architecture
The project utilizes a Layered Feature-First Architecture. This ensures that the Search, Favorites, and Recipe Detail modules are decoupled, making the app easy to test and scale.
  lib/
├── core/                 # App-wide themes, constants, and network configs
├── data/                 # The "Source of Truth"
│   ├── models/           # Logic for the Recipe schema (JSON parsing)
│   └── repositories/     # Abstracted data fetching logic
├── features/             # Feature-specific UI & Logic
│   ├── search/           # Search bar and filtering logic
│   ├── recipe_detail/    # Comprehensive recipe view & macro display
│   └── favorites/        # Local storage management
└── main.dart
The Data Schema
Our Recipe model is designed to handle comprehensive datasets. Below is the technical specification of our core entity:
Attribute,Type,Utility
difficulty,String,User-facing complexity level (Easy/Medium/Hard)
servings,Integer,Scalability factor for ingredients
macros,Integers,"Trio of Protein, Carbs, and Fat for health tracking"
tags,List<String>,SEO-style strings for high-speed filtering
instructions,List<String>,Ordered steps for the cooking process

Tech Stack & Credits
 UI: Flutter SDK (Material 3 Design)
 Image Management: cached_network_image for seamless, low-bandwidth loading.
 State Management: Designed for Riverpod / Bloc (Ready for implementation).
 Icons: Cupertino and Material Symbols.

Roadmap (Planned Features)
 Video Integration: Embedded YouTube tutorials for complex techniques.
 Shopping List: Export ingredients to a checklist.
 Offline Mode: Cache recipes for use without an internet connection.

Installation & Setup
 Environment: Ensure Flutter is installed (flutter doctor).
 Clone: git clone https://github.com/Bezawit-Ag/flutter-app.git
 Dependencies: flutter pub get
 Run: flutter run

