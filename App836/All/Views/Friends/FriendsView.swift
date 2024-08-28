//
//  FriendsView.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI

struct FriendsView: View {
    
    @StateObject var viewModel = FriendsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Friends")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .medium))
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = true
                            }
                            
                        }, label: {
                            
                            Text("+")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                                .frame(width: 20, height: 20)
                                .background(RoundedRectangle(cornerRadius: 4).fill(Color("prim")))
                        })
                    }
                }
                .padding(.bottom, 25)
                
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
        }
        .onAppear {
            
            viewModel.fetchFriends()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddFriend(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            FriendDetail(viewModel: viewModel)
        })
    }
}

#Preview {
    FriendsView()
}
