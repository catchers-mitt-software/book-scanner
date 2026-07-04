//
//  ContentView.swift
//  BookScanner
//
//  Created by Alonso del Arte on 12/19/25.
//

import SwiftUI
import VisionKit

struct ContentView: View {

    let viewController =
    DataScannerViewController(recognizedDataTypes: [.barcode()],
                              qualityLevel: .accurate,
                              recognizesMultipleItems: false,
                              isHighFrameRateTrackingEnabled: false,
                              isHighlightingEnabled: true)
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
