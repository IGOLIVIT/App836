//
//  AddFriend.swift
//  App836
//
//  Created by IGOR on 22/08/2024.
//

import SwiftUI

struct AddFriend: View {

    @StateObject var viewModel: FriendsViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add a member")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.currentPhoto = ""
                            viewModel.fName = ""
                            viewModel.fBirthday = ""
                            viewModel.fGift = ""
                            viewModel.fCost = ""
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(Color("prim"))
                                .font(.system(size: 16, weight: .regular))

                        })
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        Menu(content: {
                            
                            ForEach(viewModel.photos, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.currentPhoto = index
                                    
                                }, label: {
                                    
                                    Image(index)
                                })
                            }
                            
                        }, label: {
                            
                            if viewModel.currentPhoto.isEmpty {
                                
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.system(size: 50, weight: .regular))
                                    .frame(width: 100, height: 100)
                                    .background(Circle().stroke(Color.white.opacity(0.5)))
                                    .padding(1)
                                
                            } else {
                                
                                Image(viewModel.currentPhoto)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                        
                            }
                        })
                        .padding(.bottom)
                        
                        Text("Information")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.fName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.fName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))

                        ZStack(alignment: .leading, content: {
                            
                            Text("Birthday")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.fBirthday.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.fBirthday)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))

                            ZStack(alignment: .leading, content: {
                                
                                Text("Name gift")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.fGift.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.fGift)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 14, weight: .semibold))
                                
                            })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))

                        ZStack(alignment: .leading, content: {
                            
                            Text("Cost")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.fCost.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.fCost)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                        .padding(.bottom)
     
                        HStack {
                            
                            Button(action: {
                                
                                viewModel.currentPhoto = ""
                                viewModel.fName = ""
                                viewModel.fBirthday = ""
                                viewModel.fGift = ""
                                viewModel.fCost = ""
                                         
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAdd = false
                                }
                                
                            }, label: {
                                
                                Text("Cancel")
                                    .foregroundColor(Color("prim"))
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 20).stroke(Color("prim")))
                                    .padding(1)
                                
                            })
                            
                            Button(action: {
                                
                                viewModel.monay += Int(viewModel.fCost) ?? 0
                                
                                viewModel.fPhoto = viewModel.currentPhoto
                                
                                viewModel.addFriend()
                                
                                viewModel.currentPhoto = ""
                                viewModel.fName = ""
                                viewModel.fBirthday = ""
                                viewModel.fGift = ""
                                viewModel.fCost = ""
                                
                                viewModel.fetchFriends()
         
                                withAnimation(.spring()) {
                                    
                                    viewModel.isAdd = false
                                }
                                
                            }, label: {
                                
                                Text("Save")
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                                
                            })
                            .opacity(viewModel.fName.isEmpty || viewModel.fBirthday.isEmpty ? 0.5 : 1)
                            .disabled(viewModel.fName.isEmpty || viewModel.fBirthday.isEmpty ? true : false)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddFriend(viewModel: FriendsViewModel())
}
