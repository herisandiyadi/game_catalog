//
//  BottomSheetContent.swift
//  GameCatalog
//
//  Created by Heri Sandiyadi on 14/07/25.
//

import SwiftUI

struct BottomSheetContent: View {
    var body: some View {
        VStack{

            Button(action: {
               
            }) {
                Text("Camera")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.blue).padding()
            }
            
            Divider()
            
            Button(action: {
               
            }) {
                Text("Album")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.blue).padding()
            }

        }
    }
}

#Preview {
    BottomSheetContent()
}
