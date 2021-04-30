//
//  ContentViewModel.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Defines set of stores for your App using by view components
struct AppViewModel: ViewModel {
      
    /// Users store
    let users = RemoteStore<User, File>(
        proxy: File<User, Json<User>>(
            reader: Json(),
            fileName: "user.json"
        )
    )
    /// Books store
    let books = RemoteStore<Book, File>(
        proxy: File<Book, Json<Book>>(
            reader: Json(),
            fileName: "book.json"
        )
    )

}
