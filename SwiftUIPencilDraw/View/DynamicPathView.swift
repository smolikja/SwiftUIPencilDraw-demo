//
//  DynamicPathView.swift
//  SwiftUIPencilDraw
//
//  Created by Jakub Smolík on 24.08.2022.
//

import Foundation
import SwiftUI

struct DynamicPathView: View {
    @Binding var touchPointsArray: [[TouchModel]]

    var body: some View {
        if !touchPointsArray.isEmpty {
            ForEach(0..<touchPointsArray.count, id: \.self) { index in
                if let touches = touchPointsArray[index] {
                    ForEach(0..<touches.count, id: \.self) { index in
                        Path { path in
                            if index > 0 {
                                path.move(to: touches[index - 1].point)
                            } else {
                                path.move(to: touches[index].point)
                            }
                            path.addLine(to: touches[index].point)
                        }
                        .stroke(.black,
                                style: StrokeStyle(lineWidth: touches[index].touchForce / 250,
                                                   lineCap: .round,
                                                   lineJoin: .round))
                    }
                }
                
            }
        }
    }
}
