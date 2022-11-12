//
//  StaticPathView.swift
//  SwiftUIPencilDraw
//
//  Created by Jakub Smolík on 24.08.2022.
//

import Foundation
import SwiftUI

struct StaticPathView: View {
    @Binding var touchPointsArray: [[TouchModel]]

    var body: some View {
        if !touchPointsArray.isEmpty {
            ForEach(0..<touchPointsArray.count, id: \.self) { index in
                Path { path in
                    if let startTouch = touchPointsArray[index].first {
                        path.move(to: startTouch.point)
                        for (i, touch) in touchPointsArray[index].enumerated() {
                            if i > 0 {
                                path.move(to: touchPointsArray[index][i - 1].point)
                            }
                            path.addLine(to: touch.point)
                        }
                    }
                    path.closeSubpath()
                }
                .stroke(.black,
                        style: StrokeStyle(lineWidth: 0.8,
                                           lineCap: .round,
                                           lineJoin: .round))
            }
        }
    }
}
