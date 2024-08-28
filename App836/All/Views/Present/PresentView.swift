//
//  PresentView.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI

struct PresentView: View {
    
    @StateObject var viewModel = FriendsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                    
                    Text("Prezent plan")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                .padding(.bottom, 25)
                
                ZStack {
                    
                    VStack {
                        
                        Text("Spent")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                        
                        Text("\(viewModel.monay)$")
                            .foregroundColor(.gray)
                            .font(.system(size: 24, weight: .semibold))
                    }
                    
                    Circle()
                        .stroke(Color.gray.opacity(0.5), lineWidth: 14)
                        .frame(width: 220, height: 220)

                    Circle()
                        .trim(from: 0, to: CGFloat(viewModel.calculatePercentage() / 100))
                        .stroke(Color("prim3"), lineWidth: 14)
                        .frame(width: 220, height: 220)
                        .rotationEffect(.degrees(-90))
                }
                .padding(.vertical)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        ForEach(viewModel.friends, id: \.self) { index in
                            
                            HStack {
                                
                                Image(index.fPhoto ?? "")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                
                                Spacer()
                                
                                ForEach(viewModel.gifts.filter{($0.giFriend ?? "") == (index.fName ?? "")}.prefix(1), id: \.self) { main in
                                
                                    HStack {
                                        
                                        Text(main.giName ?? "")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text("\(main.giCost ?? "")$")
                                            .foregroundColor(.black)
                                            .font(.system(size: 15, weight: .regular))
                                    }
                                }
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("prim")))
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchFriends()
        }
        .onAppear{
            
            viewModel.fetchGitfs()
        }
    }
}

#Preview {
    PresentView()
}
