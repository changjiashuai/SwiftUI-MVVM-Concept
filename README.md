# Concept for organizing View and Data layers within SwiftUI App
SwiftUI @SwiftUI Development Architecture

# Requirements

* Swift 5

# Model

```Swift 
struct User: Model {    
    let id: Int    
    let name: String
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

* Define View and pass Store
```Swift 
UniversalList(
    store: viewModel.users,
    content: { user in userFactory(user) },
    title: "Users",
    autoLoad : true
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


