//
//  HandTrackingView.swift
//  InGest
//
//  Created by Adrian Eves on 7/5/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct HandTrackingView: View {
    @StateObject var model = HandTrackingViewModel()
    var body: some View {
        RealityView { content in
            // Content entity
            content.add(model.setupContentEntity())
        }
        .task {
            //ARKit session
            await model.runSession()
        }
        .task {
            // Process hand updates
            await model.processHandUpdates()
        }
    }
}

#Preview {
    HandTrackingView(model: HandTrackingViewModel())
}
