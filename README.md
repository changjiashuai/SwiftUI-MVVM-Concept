# SwiftUI-MVVM Organizing View and Data layers within SwiftUI App
SwiftUI Development Architecture


**Concept based on protocols.** It is not "pure" MVVM for SwiftUI as you might find on the web. It is not about how to create Lists and Charts and view design. **It's about one of possibility how to organize View and Data layers within SwiftUI App.**

**Data package** is comprised of set of classes, structs and protocols for organizing **a data layer** for apps.

App stores are assembled in AppViewModel In the code example. Two views (UniversalList, AgeChart) implementing different presentation (Chart and List) share the same Store.  When you update data in one the others are updated automatically.

Writer is not implemented in the code example. It is placed on the diagram to show the comprehensiveness of the solution for any type of communication with remote sources.

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/swiftui_mvvm.png?raw=true">

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


