//
//  Menu.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 02.06.2021.
//

import Foundation
import Data

struct MenuItem: Model {
    let id : Int
    let title: String
    let imageName: String
    
    init (_ id : Int, _ title: String, _ imageName: String) {
        self.id = id
        self.title = title
        self.imageName = imageName
    }
}

struct MenuSection: Model {
    let id : Int
    let title: String
    let items: [MenuItem]
    
    init (_ id : Int, _ title: String, _ items: [MenuItem]) {
        self.id = id
        self.title = title
        self.items = items
    }
}
