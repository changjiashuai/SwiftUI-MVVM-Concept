# Concept for organizing View and Data layers within SwiftUI App
SwiftUI @SwiftUI Development Architecture

It is not a universal solution but for some Apps it might be a suitable concept for building the architecture.
It is not about how to create List and Chart views it's about one of possibility how to organize View and Data layers within SwiftUI App.

Int the code example App stores assembled in AppViewModel. Two views (UniversalList, AgeChart) implementing different presentation (Chart and List) share the same Store.  

# Requirements

* Swift 5

# Model

```Swift 
struct User: Model {    
    let id: Int    
    let name: String
    let age: Int
}
```

# Store
* Define Store in AppViewModel
```Swift 
let users = RemoteStore<User, File>(
    proxy: File<User, Json<User>>(
        reader: Json(),
        fileName: "user.json"
    )
)
```

# View

* Define List and pass Store with users data
```Swift 
UniversalList(
    store: viewModel.users,
    content: { user in userFactory(user) },
    title: "Users"
)

```

* Define the view template(@ViewBuilder) for Store items
```Swift 
@ViewBuilder
func userFactory(_ user: User) -> some View {
    HStack {
        Text("Name: \(user.name)").font(.system(size: 14, weight: .bold))
    }
        .frame(maxWidth: .infinity)
        .background(Color.orange)
}
```


# Class-Struct Diagramm

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/mvvm.png?raw=true">


