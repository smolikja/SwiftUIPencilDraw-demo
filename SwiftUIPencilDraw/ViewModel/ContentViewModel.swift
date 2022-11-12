//
//  ContentViewModel.swift
//  SwiftUIPencilDraw
//
//  Created by Jakub Smolík on 09.08.2022.
//

import Foundation
import SwiftUI

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var touchPointsArray: [[TouchModel]] = []
        @Published var pointsCount: Int = 0
    }
}
