//
//  FriendDetail.swift
//  App836
//
//  Created by IGOR on 22/08/2024.
//

import SwiftUI

struct FriendDetail: View {
    
    @StateObject var viewModel: FriendsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text(viewModel.selectedFriend?.fName ?? "")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text("Birthday")
                                    .foregroundColor(.black)
                                    .font(.system(size: 13, weight: .regular))
                                
                                Text(viewModel.selectedFriend?.fBirthday ?? "")
                                    .foregroundColor(.black)
                                    .font(.system(size: 26, weight: .semibold))
                                
                                Text("\(viewModel.selectedFriend?.fCost ?? "")$")
                                    .foregroundColor(.black)
                                    .font(.system(size: 13, weight: .regular))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Image(viewModel.selectedFriend?.fPhoto ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("prim3")))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            
                            HStack {
                                
                                Text("Gift list")
                                    .foregroundColor(.black)
                                    .font(.system(size: 13, weight: .regular))
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isAddGift = true
                                    }
                                    
                                }, label: {
                                    
                                    Image(systemName: "pencil")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .regular))
                                        .frame(width: 25, height: 25)
                                        .background(RoundedRectangle(cornerRadius: 6).fill(Color("prim")))
                                })
                            }
                            
                            Text(viewModel.selectedFriend?.fBirthday ?? "")
                                .foregroundColor(.black)
                                .font(.system(size: 26, weight: .semibold))
                            
                            LazyVStack {
                                
                                ForEach(viewModel.gifts.filter{($0.giFriend ?? "") == (viewModel.selectedFriend?.fName ?? "")}, id: \.self) { index in
                                    
                                    VStack {
                                        
                                        HStack {
                                            
                                            Spacer()
                                            
                                            Text(index.giName ?? "")
                                                .foregroundColor(.black)
                                                .font(.system(size: 16, weight: .medium))

                                            Spacer()

                                            Text("\(index.giCost ?? "")$")
                                                .foregroundColor(.black)
                                                .font(.system(size: 13, weight: .regular))
                                            
                                            Spacer()
                                            
                                        }
                                     
                                        Rectangle()
                                            .fill(.black)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 1)
                                        
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 25.0).fill(Color("prim3")))
                    }
                }
                
                Button(action: {
                                                 
                    withAnimation(.spring()) {
                        
                        viewModel.isDelete = true
                    }
                    
                }, label: {
                    
                    Text("Delete")
                        .foregroundColor(Color("prim"))
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 20).stroke(Color("prim")))
                        .padding(1)
                    
                })
            }
            .padding()
        }
        .onAppear{
            
            viewModel.fetchGitfs()
        }
        .sheet(isPresented: $viewModel.isAddGift, content: {
            
            AddGift(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                        })
                    }
                    
                    Text("Delete")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                    
                    Text("Are you sure you want to delete?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
               
                        CoreDataStack.shared.deleteFriend(withPName: viewModel.selectedFriend?.fName ?? "", completion: {
                            
                            viewModel.fetchFriends()
                        })
          
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                            viewModel.isDetail = false

                        }
                                
                    }, label: {
                        
                        Text("Delete")
                            .foregroundColor(.red)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                    .padding(.top, 25)
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                        
                    }, label: {
                        
                        Text("Close")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                        
                    })
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    FriendDetail(viewModel: FriendsViewModel())
}
