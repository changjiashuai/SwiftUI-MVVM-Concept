//
//  MovieFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Ui


/// Set of templates for Master Detail View presenting Ganges and Movies
struct MovieFactory {

    /// Set of elementary elms for creating View
    let build: ElementBuilder
    
    // MARK: - Life circle
    
    init(_ build: ElementBuilder){
        self.build = build
    }
    
    // MARK: - API Methods
    
    /// Create view template for defining Ganre in the Master list
    /// - Parameter ganre: Set of data for Ganre
    /// - Returns: View defining how Ganre should be presented in the list
    @ViewBuilder
    func ganre(_ ganre: Ganre, _ selected: Ganre?) -> some View {
        let isSelexted = ganre.id == selected?.id
        build.row("\(ganre.title)")
            .foregroundColor( isSelexted ? Color.yellow : Color.pink)
    }

    /// Create view template for defining Movie in the Detail list
    /// - Parameter movie: Set of data for Movie
    /// - Returns: View defining how Movie should be presented in the list
    @ViewBuilder
    func movie(_ movie: Movie) -> some View {
        build.row("\(movie.title)")
            .foregroundColor(Color.purple)
    }
}
