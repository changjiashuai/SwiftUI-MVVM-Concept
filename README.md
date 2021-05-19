# SwiftUI MVVM Concept
It is not about how to create Lists and Charts and view design. **It's about possibility how to organize View and Data layers within SwiftUI App.**

## Organizing View and Data layers within SwiftUI App
**Concept based on protocols.** It is not "typical" MVVM for SwiftUI as you might find on the web. 

### SwiftUI template Development Architecture Designing with Protocols

App stores are assembled in AppViewModel In the code example. Two views (UniversalList, AgeChart) implementing different presentation (Chart and List) share the same Store.  When you update data in one the others are updated automatically.

| Package | Description |
| --- | --- |
| **Data** | The package  is comprised of set of classes, structs and protocols for organizing infrastructure for **a data layer** in apps.| 
|**Service**|  The package is comprised of set of classes, structs and protocols for implementing different services like authentication etc.|
|**Ui**|  The package  is comprised of view components that might be shared between diff projects.|

Writer is not implemented in the code example. It is placed on the diagram to show the comprehensiveness of the solution for any type of communication with remote sources.

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/swiftui_mvvm_architecture.png?raw=true">

## Requirements

* Xcode Version 12+ Swift 5.3

## Model
* Define Model describing you entity
```Swift 
struct User: Model {    
    let id: Int    
    let name: String
    let age: Int
}
```

## Store
* Define Store in AppViewModel. It's **store** parameter for **UniversalList** View
* Proxy is defining a communication layer. Proxies are used by Store to handle the loading and saving of Model data
* Readers are used to interpret data to be loaded into a Model instance
```Swift 
let store = RemoteStore<User, File>(
    proxy: File<User, Json>(
        reader: Json<User>(),
        fileName: "user.json"
    )
)
```

## View

* Define View component and pass Store
```Swift 
UniversalList(
    store: store,
    content: content,
    toolBar: toolBar
)
```

* Define the template(**@ViewBuilder**) for creating View depicting entity. It's **content** parameter for **UniversalList** View
```Swift 
@ViewBuilder
func user(_ user: User) -> some View {
    HStack {
        Text("Name: \(user.name)")
    }
}
```


# Class-Struct Diagramm

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/mvvm.png?raw=true">


# UI behavior
Click to watch the expected UI behavior for the example

* Shared source of data with different presentations
* Views control
* Dynamically added Views
* Master detail view 
* Sign in sign out 
* Requesting data with authentication token


[![click to watch expected UI behavior for the example](https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/video.png)](https://www.youtube.com/watch?v=C5p1GdggNUQ)
