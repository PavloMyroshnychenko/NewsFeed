# MVP_Template-iOS

## Project setup
1. Download project
2. Update project name
3. Update folders names
4. Update info.plist path in build settings
5. Update project name in files headers
6. Update project name in podfile
7. Run pod deintegrate and pod install commands
8. Update project name in .swiftlint.yml file
9. Update network layer:
    - Rename Template_project.swift file
    - Rename Template_project struct
    - Rename TemplatePromise
    - Rename TemplateNetwork.swift and update according to your REST API
    - Rename TemplateProvider.swift and update according to your REST API
    - Update AuthNetwork and AuthProvider according to your REST API
10. Use Constants file for all strings, and common constants
11. Check MainNavigationController.swift for navigation example
12. Check Template flow for Presenter and Controller example
13. Check Extension folder for added extensions
14. Setup Crashlytics

## Project Architecture - MVP

## Added Pods
- Moya
- PromiseKit
- RealmSwift
- SwiftLint
- Locksmith

## Firebase Crashlytics setup
For separate Crashlytics for debug and release use this script and name your `GoogleService-Info.plist` like `GoogleService-Info-Debug.plist` and `GoogleService-Info-Release.plist`:

```bash
PATH_TO_GOOGLE_PLISTS="${PROJECT_DIR}/App_template_folder_name"

case "${CONFIGURATION}" in

   "Debug" )
        cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Debug.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;

   "Release" )
        cp -r "$PATH_TO_GOOGLE_PLISTS/GoogleService-Info-Release.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist" ;;

    *)
        ;;
esac
```

## Template configuration
For more easy work with this template use Xcode files templates.
For configuring It move the MVP folder to `/Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File Templates`.

## General info
- UserDetailsStore.swift - Service for storing info in keychain
- Log.swift - Logger
- Database.swift - Generic Realm service

## General recomendations
- Use DateFormatter to format dates
- Use NumberFormatter to format numbers
- If you need format currency use NumberFormatter (check Apple documentation)
- Use optimization tips for better application performance (https://github.com/apple/swift/blob/main/docs/OptimizationTips.rst)

## Code style for Swift programming language can be found at:
- https://google.github.io/swift
- https://github.com/raywenderlich/swift-style-guide
- https://www.swift.org/documentation/api-design-guidelines/

