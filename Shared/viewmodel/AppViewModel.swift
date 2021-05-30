//
//  ContentViewModel.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 29.04.2021.
//

import Foundation
import Data

/// Defines set of stores for your App used by view components
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
    
    let ganre = RemoteStore<Ganre, File>(
        proxy: File<Ganre, Json>(
            reader: Json<Ganre>(),
            fileName: "ganre.json"
        )
    )

    let movie = RemoteStore<Movie, File>(
        proxy: File<Movie, Json>(
            reader: Json<Movie>(),
            fileName: "movie.json"
        )
    )
    
    func getFileJsonStore<T: Model>(from fileName: String) -> RemoteStore<T, File<T, Json<T>>>{
        RemoteStore(
            proxy: File(
                reader: Json(),
                fileName: fileName
            )
        )
    }
}
