//
//  ContentView.swift
//  SwiftUIPencilDraw
//
//  Created by Jakub Smolík on 09.08.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var staticPath = true
    var body: some View {
        VStack {
            Button(staticPath ? "static" : "dynamic") {
                viewModel.touchPointsArray = []
                viewModel.pointsCount = 0
                staticPath.toggle()
            }
            .padding(.top,16)
            ZStack {
                Text("Points count \(viewModel.pointsCount)")
                if staticPath {
                    StaticPathView(touchPointsArray: $viewModel.touchPointsArray)
                } else {
                    DynamicPathView(touchPointsArray: $viewModel.touchPointsArray)
                }
                GestureRecognizerWrap(contentVM: viewModel)
            }
        }
    }
}
