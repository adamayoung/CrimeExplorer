//
//  CrimeMapMarker.swift
//  CrimeExplorer
//
//  Created by Adam Young on 26/05/2021.
//

import CrimeExplorerCore
import SwiftUI

struct CrimeMapMarker: View {

    var category: CrimeCategory

    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        Circle()
            .fill(category.backgroundColor)
            .frame(width: 32, height: 32)
            .overlay(Group {
                category.image
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            })
            .scaleEffect(scale)
            .opacity(opacity)
            .animation(.spring())
            .onAppear {
                scale = 1
                opacity = 1
            }
            .onDisappear {
                scale = 0.5
                opacity = 0
            }
    }
}

struct CrimeMapMarker_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            ForEach(CrimeCategory.allCases, id: \.self) {
                CrimeMapMarker(category: $0)
                    .previewLayout(.sizeThatFits)
                    .previewDisplayName($0.description)
            }

        }
    }

}
