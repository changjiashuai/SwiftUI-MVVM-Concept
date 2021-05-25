//
//  MovieFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Ui


/// Set of templates for Master Detail View presenting Ganges and Movies
struct MovieFactory: GridBuilder {
    
    // MARK: - API Methods
    
    /// Create view template for defining Ganre in the Master list
    /// - Parameter ganre: Set of data for Ganre
    /// - Parameter selected: True - if selected
    /// - Returns: View defining how Ganre should be presented in the list
    /// GridBuilder.row - Create View of a row
    @ViewBuilder
    func ganre(_ ganre: Ganre, _ selected: Bool) -> some View {
        let color: Color = selected ? .yellow : .pink
        row("\(ganre.title)", color)
    }

    /// Create view template for defining Movie in the Detail list
    /// - Parameter movie: Set of data for Movie
    /// - Returns: View defining how Movie should be presented in the list
    /// GridBuilder.row - Create View of a row
    @ViewBuilder
    func movie(_ movie: Movie) -> some View {
        row("\(movie.title)", .purple)
    }
}
