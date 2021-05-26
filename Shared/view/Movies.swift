//
//  Movies.swift
//  UniversalComponent
//
//  Created by Igor Shelopaev on 19.05.2021.
//

import SwiftUI
import Ui

/// Master detail view with ganres and movies
struct Movies: View {

    /// Item view factory
    let item = MovieFactory()
    
    @State var masterIsLoading: Bool = false

    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel

    /// The type of view representing the body of this view
    var body: some View {

        HStack(spacing: 2) {
            Master(
                store: viewModel.ganre,
                detail: viewModel.movie,
                content: item.ganre,
                toolBar: ToolBar<EmptyView>("Ganre", showControls: false),
                masterIsLoading : $masterIsLoading
            )
            Detail(
                store: viewModel.movie,
                content: item.movie,
                toolBar: ToolBar<EmptyView>("Movie", showControls: false),
                masterIsLoading : $masterIsLoading
            )
        }
            .mask(masterIsLoading, text: "Ganre is loading")
            .padding(.trailing)
            .padding(.vertical)
            .frame(minWidth: 320)
    }
}

