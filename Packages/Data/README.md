# Data

Data package is comprised of set of classes, structs and protocols for organizing a data layer for apps

## Requirements

* Xcode Version 12+ Swift 5.0

## Model
* Model is describing entity
```Swift 
struct User: Model {    
    let id: Int    
    let name: String
    let age: Int
}
```

## Store
* Store is managing data for Views
```Swift 
let store = RemoteStore<User, File>(
    proxy: File<User, Json>(
        reader: Json<User>(),
        fileName: "user.json"
    )
)
