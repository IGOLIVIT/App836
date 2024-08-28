//
//  U1.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI

struct U1: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("U1")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    
                    Text("Start now and earn more")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                        .padding(.vertical)
                    
                    Text("A proven way to make easy money")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        Reviews()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Text("Next")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 17).fill(Color("prim")))
                    })
                }
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 250)
            }
        }
    }
}

#Preview {
    U1()
}
