//
//  ContentViewModel.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Defines set of stores for your App using by view components
class AppViewModel: ViewModel, ObservableObject {

    let users = RemoteStore<User, File>(
        proxy: File<User, Json>(
            reader: Json<User>(),
            fileName: "user.json"
        )
    )

    let books = RemoteStore<Book, File>(
        proxy: File<Book, Json>(
            reader: Json<Book>(),
            fileName: "book.json"
        )
    )
    
}
