//
//  HomeView.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = FriendsViewModel()
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                VStack {
                    
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
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
                }
                .padding()
                
                VStack {
                    
                    if viewModel.friends.isEmpty {
                        
                        VStack {
                            
                            Image(systemName: "person.3.fill")
                                .foregroundColor(Color.gray.opacity(0.7))
                                .font(.system(size: 80, weight: .regular))
                            
                            Text("Your friends list is empty, add new friends")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                            
                        }
                        .frame(maxHeight: .infinity)
                        
                    } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.friends, id: \.self) { index in
                                
                                VStack(spacing: 5) {
                                    
                                    HStack {
                                        
                                        Text(index.fName ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Image(index.fPhoto ?? "")
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                    }
                                    
                                    Spacer()
                                    
                                    HStack {
                                        
                                        Text("Birthday")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .medium))
                                        
                                        Spacer()
                                        
                                        Text("Days left")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15, weight: .medium))
                                    }
                                    
                                    HStack {
                                        
                                        Text(index.fBirthday ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 13, weight: .regular))
                                        
                                        Spacer()
                                        
                                        Text("\(index.fCost ?? "") days")
                                            .foregroundColor(.white)
                                            .font(.system(size: 13, weight: .regular))
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        viewModel.selectedFriend = index
                                        
                                        withAnimation(.spring()) {
                                            
                                            viewModel.isDetail = true
                                        }
                                        
                                    }, label: {
                                        
                                        Text("More details")
                                            .foregroundColor(.black)
                                            .font(.system(size: 13, weight: .medium))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 25)
                                            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                                    })
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .frame(height: 160)
                                .background(RoundedRectangle(cornerRadius: 20).fill(.black))
                            }
                        })
                    }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .onAppear {
            
            viewModel.fetchFriends()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddFriend(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            FriendsView(viewModel: viewModel)
        })
    }
}

#Preview {
    HomeView()
}
