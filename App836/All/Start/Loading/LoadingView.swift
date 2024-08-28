//
//  LoadingView.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("Llogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    LoadingView()
}
