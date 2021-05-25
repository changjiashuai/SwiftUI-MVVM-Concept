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

    /// App viewModel
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {

        HStack(spacing: 2) {
            Master(
                store: viewModel.ganre,
                detail: viewModel.movie,
                content: item.ganre,
                toolBar: ToolBar<EmptyView>("Ganre", showControls: false)
            )
            Detail(
                store: viewModel.movie,
                content: item.movie,
                toolBar: ToolBar<EmptyView>("Movie", showControls: false)
            )
        }
            .padding(.trailing)
            .padding(.vertical)
            .frame(minWidth: 320)
    }
}

