//
//  FriendsViewModel.swift
//  App836
//
//  Created by IGOR on 21/08/2024.
//

import SwiftUI
import CoreData

final class FriendsViewModel: ObservableObject {
    
    @AppStorage("money") var monay: Int = 1

    @Published var photos: [String] = ["a1", "a2", "a3", "a4"]
    @Published var currentPhoto = ""

    @Published var isAdd: Bool = false
    @Published var isAddGift: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    
    @Published var fName: String = ""
    @Published var fPhoto: String = ""
    @Published var fGift: String = ""
    @Published var fCost: String = ""
    @Published var fBirthday: String = ""

    @Published var friends: [FriendModel] = []
    @Published var selectedFriend: FriendModel?
    
    func addFriend() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "FriendModel", into: context) as! FriendModel

        loan.fName = fName
        loan.fPhoto = fPhoto
        loan.fGift = fGift
        loan.fCost = fCost
        loan.fBirthday = fBirthday

        CoreDataStack.shared.saveContext()
    }

    func fetchFriends() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<FriendModel>(entityName: "FriendModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.friends = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.friends = []
        }
    }
    
    @Published var giName: String = ""
    @Published var giCost: String = ""
    @Published var giFriend: String = ""

    @Published var gifts: [GiftModel] = []
    @Published var selectedGift: GiftModel?
    
    func addGitf() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "GiftModel", into: context) as! GiftModel

        loan.giName = giName
        loan.giCost = giCost
        loan.giFriend = giFriend

        CoreDataStack.shared.saveContext()
    }

    func fetchGitfs() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<GiftModel>(entityName: "GiftModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.gifts = result
            
        } catch let error as NSError {
            
            print("catch")
            
            print("Error fetching persons: \(error), \(error.userInfo)")
            
            self.gifts = []
        }
    }
    
    func calculatePercentage() -> Double {
        
        let value = monay
        let maxValue = 100000
        
        let percentCircle = Double(value) / Double(maxValue) * 100
        
        return percentCircle
    }
}
