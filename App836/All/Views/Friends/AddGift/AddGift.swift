//
//  AddGift.swift
//  App836
//
//  Created by IGOR on 22/08/2024.
//

import SwiftUI

struct AddGift: View {
    
    @StateObject var viewModel: FriendsViewModel
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Add gift")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        Text("Name")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.giName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.giName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                        
                        Text("Cost")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Cost")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.giCost.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.giCost)
                                .foregroundColor(Color.white)
                                .font(.system(size: 14, weight: .semibold))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                    }
                    
                }
                
                HStack {
                    
                    Button(action: {
                                                         
                        withAnimation(.spring()) {
                            
                            viewModel.isAddGift = false
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
                        
                        viewModel.monay += Int(viewModel.giCost) ?? 0
                        
                        viewModel.giFriend = viewModel.selectedFriend?.fName ?? ""
                        
                        viewModel.addGitf()
                        
                        viewModel.giName = ""
                        viewModel.giCost = ""
                        
                        viewModel.fetchGitfs()
 
                        withAnimation(.spring()) {
                            
                            viewModel.isAddGift = false
                        }
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color("prim")))
                        
                    })
                    .opacity(viewModel.giName.isEmpty || viewModel.giCost.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.giName.isEmpty || viewModel.giCost.isEmpty ? true : false)
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddGift(viewModel: FriendsViewModel())
}
