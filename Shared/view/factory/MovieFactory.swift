//
//  MovieFactory.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI


/// Set of templates for Master Detail View presenting Ganges and Movies
struct MovieFactory {

    /// Create view template for defining Ganre in the Master list
    /// - Parameter book: Set of data for Ganre
    /// - Returns: View defining how Ganre should be presented in the list
    @ViewBuilder
    func ganre(_ ganre: Ganre, _ selected: Ganre?) -> some View {
        HStack {
            Rectangle().overlay(Text("Title: \(ganre.title)").foregroundColor(.white).font(.system(.headline)), alignment: .center)
        }
            .frame(maxWidth: .infinity)
            .frame(height: 25)
        .foregroundColor(ganre.id == selected?.id ? Color.yellow : Color.pink)
    }

    /// Create view template for defining Movie in the Detail list
    /// - Parameter movie: Set of data for Movie
    /// - Returns: View defining how Movie should be presented in the list
    @ViewBuilder
    func movie(_ movie: Movie) -> some View {
        HStack {
            Rectangle().overlay(Text("Title: \(movie.title)").foregroundColor(.white).font(.system(.headline)), alignment: .center)
        }
            .frame(maxWidth: .infinity)
            .frame(height: 25)
        .foregroundColor(Color.purple)
    }
}
