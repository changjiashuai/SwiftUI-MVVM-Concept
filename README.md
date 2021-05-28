# SwiftUI MVVM Concept
It is not about how to create Lists and Charts and View design. **It's about possibility how to organize View and Data layers within SwiftUI App.**

## Organizing View and Data layers within SwiftUI App
**Concept based on protocols.** It is not "typical" MVVM for SwiftUI as you might find on the web. 

# Aspirations

* Decouple View and Data layers and loosen dependencies between them
* Easily change a data source  from  Web to File etc.
* Easily change a data source format  from JSON to XML, XML to CSV etc.
* Share the same data source between different View presentations(Grid, Chart other components)
* Maximize reusing code between different projects
* Easily split the development of View and Data layers between independent developers
* Testability

## The principle of the concept is 1-2-3


### 1. Model
* Define Model
```Swift 
struct User: Model {    
    let id: Int    
    let name: String
    let age: Int
}
```

### 2. Store
* Define Store
> It's **store** parameter for **UniversalList** View in the example
* Proxy is defining a communication layer. Proxies are used by Store to handle the loading and saving of Model data
* Reader is used to interpret data to be loaded into a Model instance
```Swift 
RemoteStore(
    proxy: File(
        reader: Json(),
        fileName: fileName
    )
)
```

### 3. View
* Define View
```Swift 
UniversalList(
    store: store,
    content: content,
    toolBar: toolBar
)
```
> **content** parameter is a template for creating View depicting an entity 
> **toolBar** set of predefined controls to manage View plus you can add your cystom set 

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/swiftui_mvvm_architecture.png?raw=true">

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/composition.png?raw=true">

### SwiftUI template Development Architecture Designing with Protocols
App stores are assembled in AppViewModel In the code example. Two views (UniversalList, BarChart) implementing different presentation (Chart and List) share the same Store.
| Package | Description |
| --- | --- |
| **Data** | The package  is comprised of set of classes, structs and protocols for organizing infrastructure for **a data layer** in apps.| 
|**Service**|  The package is comprised of set of classes, structs and protocols for implementing different services like authentication etc.|
|**Ui**|  The package  is comprised of view components that might be shared between diff projects.|

> Writer is not implemented in the code example. It is placed on the diagram to show the comprehensiveness of the solution for any type of communication with remote sources


# Class-Struct Diagramm

<img src="https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/mvvm.png?raw=true">


# UI behavior

**Click or tap the picture to watch the expected UI behavior of the example**

* Shared source of data with different presentations
* Views control
* Dynamically added Views
* Master detail view 
* Sign in sign out

[![click to watch expected UI behavior for the example](https://github.com/The-Igor/SwiftUI-MVVM-Concept/blob/main/Resources/readme_app.png)](https://youtu.be/zFkxT3cqdaA)

## Requirements

* Xcode Version 12.5+ Swift 5.3




