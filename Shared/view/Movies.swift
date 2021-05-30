//
//  Movies.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Ui
import Data

/// Master detail view with ganres and movies
struct Movies: View {
    
    /// Item view factory
    let item = MovieFactory()
    
    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel
    
    /// Current command
    @State var curentCommand: StoreCommand = StoreCommand()
    
    /// The type of view representing the body of this view
    var body: some View {
        
        HStack(spacing: 2) {
            Master(
                store: viewModel.ganre,
                content: item.ganre,
                toolBar: ToolBar<EmptyView>("Ganre", showControls: false),
                curentCommand : $curentCommand
            )
            Detail(
                store: viewModel.movie,
                content: item.movie,
                toolBar: ToolBar<EmptyView>("Movie", showControls: false),
                curentCommand : $curentCommand
            )
        }
        .padding(5)
    }
    
}

