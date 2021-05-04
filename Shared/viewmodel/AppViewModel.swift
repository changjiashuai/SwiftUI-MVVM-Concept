//
//  ContentViewModel.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation

/// Defines set of stores for your App using by view components
class AppViewModel: ViewModel, ObservableObject {
          
   func getUsers() -> RemoteStore<User, File<User, Json<User>>>{
        return RemoteStore<User, File>(
            proxy: File<User, Json>(
                reader: Json<User>(),
                fileName: "user.json"
            )
        )
    }
    
    func getBooks() -> RemoteStore<Book, File<Book, Json<Book>>>{
        return RemoteStore<Book, File>(
            proxy: File<Book, Json>(
                reader: Json<Book>(),
                fileName: "book.json"
            )
        )
    }

}
