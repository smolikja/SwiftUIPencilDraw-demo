//
//  GestureRecognizerView.swift
//  SwiftUIPencilDraw
//
//  Created by Jakub Smolík on 09.08.2022.
//

import Foundation
import UIKit
import SwiftUI

struct GestureRecognizerWrap: UIViewRepresentable {
    let contentVM: ContentView.ViewModel

    func makeUIView(context: Context) -> UIView {
        GestureRecognizerView(contentVM: contentVM)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

class GestureRecognizerView: UIView {
    private let stylusMaximumPressureValue: Float = 2048.0;
    private var contentVM: ContentView.ViewModel?
    
    enum FuncType {
        case touchesBegan
        case touchesMovedEnded
    }

    init(contentVM: ContentView.ViewModel?) {
        super.init(frame: .zero)
        self.contentVM = contentVM
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func handleTouches(_ touches: Set<UITouch>, funcType: FuncType) {
//        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "timestamp",
//                                                            ascending: false)
//        let sortedTouches = Array(touches)?.sortedArray(using: [descriptor])
        for touch in touches {
            if touch.type != .pencil {
                continue
            }
            let location = touch.preciseLocation(in: self)
            let scale = contentScaleFactor
            let pixelPoint = CGPoint(x: location.x * scale,
                                     y: location.y * scale)
            
            let touchForce = touch.force / touch.maximumPossibleForce * CGFloat(stylusMaximumPressureValue)
            let touchObj = TouchModel(point: pixelPoint,
                                      touchForce: touchForce) //TODO: vypocitat z predchoziho bodu po aktualni
            switch funcType {
            case .touchesBegan:
                contentVM?.touchPointsArray.append([touchObj])
            case .touchesMovedEnded:
                let touchPointsArrayLength = contentVM?.touchPointsArray.count
                contentVM?.touchPointsArray[touchPointsArrayLength! - 1].append(touchObj)
            }
            contentVM?.pointsCount += 1
        }
    }
}

extension GestureRecognizerView: UIGestureRecognizerDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches,
                      funcType: .touchesBegan)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches,
                      funcType: .touchesMovedEnded)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches,
                      funcType: .touchesMovedEnded)
    }
}
