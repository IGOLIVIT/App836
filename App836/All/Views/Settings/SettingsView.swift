//
//  SettingsView.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .medium))
                    .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Button(action: {
                            
                            SKStoreReviewController.requestReview()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("prim3"))
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(width: 30, height: 30)
                                    .background(RoundedRectangle(cornerRadius: 6).fill(.black))
                                
                                Text("Rate us")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Spacer()
                                
                                Text("Rate")
                                    .foregroundColor(.black)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(5)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 25.0).fill(.black.opacity(0.1)))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color("prim3")))
                        })
                        
                        Button(action: {
                            
                            guard let url = URL(string: "") else { return }
                            
                            UIApplication.shared.open(url)
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "person.badge.shield.checkmark.fill")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 26, weight: .regular))
                                
                                Text("Usage Policy")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Spacer()
                                
                                Text("Read")
                                    .foregroundColor(.black)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(5)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 25.0).fill(.black.opacity(0.1)))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color("prim3")))
                        })
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
