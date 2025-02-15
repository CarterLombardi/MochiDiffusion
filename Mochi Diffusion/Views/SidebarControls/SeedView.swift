//
//  SeedView.swift
//  Mochi Diffusion
//
//  Created by Joshua Park on 12/26/22.
//

import SwiftUI

struct SeedView: View {
    @EnvironmentObject private var controller: ImageController
    @FocusState private var seedFieldIsFocused: Bool

    var body: some View {
        Text("Seed")
            .sidebarLabelFormat()
        HStack {
            TextField("random", value: $controller.seed, formatter: Formatter.seedFormatter)
                .focused($seedFieldIsFocused)
                .textFieldStyle(.roundedBorder)
            Button {
                seedFieldIsFocused = false
                /// ugly hack
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    ImageController.shared.seed = 0
                }
            } label: {
                Image(systemName: "shuffle")
                    .frame(minWidth: 18)
            }
        }
    }
}

extension Formatter {
    static let seedFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimum = 0
        // swiftlint:disable:next legacy_objc_type
        formatter.maximum = NSNumber(value: UInt32.max)
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = false
        formatter.hasThousandSeparators = false
        formatter.alwaysShowsDecimalSeparator = false
        formatter.zeroSymbol = ""
        return formatter
    }()
}

struct SeedView_Previews: PreviewProvider {
    static var previews: some View {
        SeedView()
            .environmentObject(ImageController.shared)
    }
}
