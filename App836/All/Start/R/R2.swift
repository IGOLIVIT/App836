//
//  R2.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI

struct R2: View {
    
    @AppStorage("status") var status: Bool = false

    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("R2")
                    .resizable()
                    .ignoresSafeArea()

                VStack {
                    
                    Text("Add new friends")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                        .padding(.vertical)
                    
                    Text("Put up their birth dates so you don't forget them")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                    
                    Button(action: {
                        
                        status = true
                        
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
    R2()
}
