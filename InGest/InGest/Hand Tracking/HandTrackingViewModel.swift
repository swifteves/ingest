//
//  HandTrackingViewModel.swift
//  InGest
//
//  Created by Adrian Eves on 7/5/24.
//

import RealityKit
import RealityKitContent
import SwiftUI
import ARKit

@MainActor
class HandTrackingViewModel: ObservableObject {
    private let session = ARKitSession()
    private let handTracking = HandTrackingProvider()
    
    private let sceneReconstruction = SceneReconstructionProvider()
    
    private var contentEntity = Entity()
    
    private var meshEntities = [UUID: ModelEntity]()
    
    private var jointEntities: [HandAnchor.Chirality: [HandSkeleton.JointName: ModelEntity]] = [
        .left: [:],
        .right: [:]
    ]
        
    func setupContentEntity() -> Entity {
        for chirality in [HandAnchor.Chirality.left, .right] {
            for joint in HandSkeleton.JointName.allCases {
                let entity = ModelEntity.createJointMarker()
                jointEntities[chirality]?[joint] = entity
                contentEntity.addChild(entity)
            }
        }
        
        return contentEntity
    }
    
    func runSession() async {
        do {
            try await session.run([sceneReconstruction, handTracking])
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    func processHandUpdates() async {
        for await update in handTracking.anchorUpdates {
            let handAnchor = update.anchor
            
            guard handAnchor.isTracked else { continue }
            
            guard let handSkeleton = handAnchor.handSkeleton else { continue }
            
            for joint in HandSkeleton.JointName.allCases {
                guard let jointEntity = jointEntities[handAnchor.chirality]?[joint],
                      let jointTransform = getJointOrigin(joint: handSkeleton.joint(joint), anchor: handAnchor) else {
                    continue
                }
                
                jointEntity.setTransformMatrix(jointTransform, relativeTo: nil)
            }
        }
    }
    
    func getJointOrigin(joint: HandSkeleton.Joint?, anchor: HandAnchor) -> float4x4? {
        guard let joint = joint, joint.isTracked else { return nil }
        
        let originFromWrist = anchor.originFromAnchorTransform
        let wristFromJoint = joint.anchorFromJointTransform
        let originFromJoint = originFromWrist * wristFromJoint
        return originFromJoint
    }
}

extension ModelEntity {
    static func createJointMarker() -> ModelEntity {
        let entity = ModelEntity(mesh: .generateSphere(radius: 0.005),
                                 materials: [SimpleMaterial(color: .red, isMetallic: true)])
        return entity
    }
}
