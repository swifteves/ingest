//
//  InGestApp.swift
//  InGest
//
//  Created by Adrian Eves on 6/16/24.
//

import SwiftUI

@main
struct InGestApp: App {
    var body: some SwiftUI.Scene {
        ImmersiveSpace(id: "HandViewSpace") {
            HandTrackingView()
        }
        .upperLimbVisibility(.hidden)
     }
}
