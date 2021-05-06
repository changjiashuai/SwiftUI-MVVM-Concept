# Organizing View and Data layers within SwiftUI App
SwiftUI @SwiftUI Development Architecture

**Concept based on protocols.** It is not "pure" MVVM for SwiftUI as you might find on the web. It is not about how to create List and Chart views. **It's about one of possibility how to organize View and Data layers within SwiftUI App.**

App stores are assembled in AppViewModel In the code example. Two views (UniversalList, AgeChart) implementing different presentation (Chart and List) share the same Store.  

Writer is not implemented in the code example. It is placed on the diagram to show the comprehensiveness of the solution for any type of communication with remote sources.

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/swiftui_mvvm.png?raw=true">

## Requirements

* Xcode Version 12+ Swift 5.0

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
* Define Store in AppViewModel
```Swift 
let users = RemoteStore<User, File>(
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
    content: userFactory,
    store: viewModel.users,
    title: "Users"
)
```

* Define the template(@ViewBuilder) for creating view depicting entity
```Swift 
@ViewBuilder
func userFactory(_ user: User) -> some View {
    HStack {
        Text("Name: \(user.name)")
    }
}
```


# Class-Struct Diagramm

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/mvvm.png?raw=true">


