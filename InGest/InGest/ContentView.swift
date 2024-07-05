//
//  ContentView.swift
//  InGest
//
//  Created by Adrian Eves on 6/16/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("InGest")
//                .font(.system(.extraLargeTitle, design: .rounded))
//                .font(.extraLargeTitle)
//            HStack(spacing: 20) {
//                RoundedButton(symbol: "movieclapper.fill", title: "Record")
//                RoundedButton(symbol: "film.stack", title: "Library")
//                RoundedButton(symbol: "gearshape.fill", title: "Settings")
//            }
//            .padding()
//        }
//    }
//}
//
//struct RoundedButton: View {
//    let symbol: String
//    let title: String
//    @State private var isHovering = false
//    
//    var body: some View {
//        VStack {
//            Image(systemName: symbol)
//                .font(.system(size: 50))
//                .padding(.bottom, 5)
//            Text(title)
//                .font(.headline)
//        }
//        .frame(width: 120, height: 120)
//        .background(isHovering ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
//        .cornerRadius(15)
//        .onHover { hovering in
//            isHovering = hovering
//        }
//        .animation(.easeInOut(duration: 0.2), value: isHovering)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HStack(spacing: 20) {
                NavigationLink(destination: FavoriteView()) {
                    RoundedButtonView(symbol: "movieclapper.fill", title: "Record")
                }
                .glassBackgroundEffect(displayMode: .never)
                NavigationLink(destination: AlertsView()) {
                    RoundedButtonView(symbol: "film.stack", title: "Library")
                }
                .glassBackgroundEffect(displayMode: .never)
                NavigationLink(destination: SettingsView()) {
                    RoundedButtonView(symbol: "gearshape.fill", title: "Settings")
                }
                .glassBackgroundEffect(displayMode: .never)
            }
            .padding()
            .glassBackgroundEffect(displayMode: .never)
        }
    }
}

struct RoundedButtonView: View {
    let symbol: String
    let title: String

    var body: some View {
        VStack {
            Image(systemName: symbol)
                .font(.system(size: 50))
                .padding(.bottom, 5)
            Text(title)
                .font(.headline)
        }
        .frame(width: 250, height: 250)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .shadow(radius: 5)
        )
        .hoverEffect()
    }
}

struct FavoriteView: View {
    var body: some View {
        VStack {
            Text("Favorite View")
                .font(.largeTitle)
                .padding()
            // Add additional content for the Favorite view here
        }
    }
}

struct AlertsView: View {
    var body: some View {
        VStack {
            Text("Alerts View")
                .font(.largeTitle)
                .padding()
            // Add additional content for the Alerts view here
        }
    }
}

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings View")
                .font(.largeTitle)
                .padding()
            // Add additional content for the Settings view here
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
