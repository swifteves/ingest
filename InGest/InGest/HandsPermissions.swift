//
//  HandsPermissions.swift
//  InGest
//
//  Created by Adrian Eves on 6/22/24.
//

import Foundation
import ARKit

class HandsPermissions {
    
    // This is meant for the recording features.
    // We shouldn't gatekeep viewing and editing
    // existing gestures.
     
    let session = ARKitSession()
    
    static func isAllowed() async -> Bool {
        let instance = HandsPermissions()
        return await instance.isHandTrackingAllowed()
    }
    
    func isHandTrackingAllowed() async -> Bool {
        let authorisationResult = await session.requestAuthorization(for: [.handTracking])
        
        for (authorisationType, authorisationStatus) in authorisationResult {
            print("Authorisation status for \(authorisationType): \(authorisationStatus)")
            
            switch authorisationStatus {
            case .allowed:
                return true
            case .denied, .notDetermined:
                return false
            @unknown default:
                return false
            }
        }
        
        return false
    }
    
}
