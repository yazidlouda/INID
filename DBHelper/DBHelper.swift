//
//  DBHelper.swift
//  INID
//
//  Created by Home on 8/17/21.
//

import Foundation
import UIKit
import CoreData

class DBHelper {
    static var inst = DBHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func addUser(object : [String:String]) { // adds the username and login info to the core data
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.username = object["username"]
        user.password = object["password"]
       

        do {
            try context?.save()
            print("User created with username:", user.username!, "and password:", user.password!)
        } catch {
            print("Account not created.")
        }
    }
    func getAccounts()->[User] { 
        var a = [User]()
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            a = try context?.fetch(fetchReq) as! [User]
        } catch {
            print("Could not find user.")
        }
        
        return a
    }
    func getOneAccount (username : String)-> User { // checks for one specific instance of account credentials to see if it exists in coredata
        var a : User?
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        fetchReq.fetchLimit = 1
        do {
            let req = try context?.fetch(fetchReq) as! [User]
            if(req.count != 0){
                a = req.first!
            }
            else { // Account data doesn't exist
                print("Account data not found.")
            }
        }
        catch {
            print("Error.")
        }
        
        return a!
    }
    
    func addCurrUser(object: String) {
        var cUser : [CurrentUser] = []
        cUser.append(NSEntityDescription.insertNewObject(forEntityName: "CurrentUser", into: context!) as! CurrentUser)

        cUser[0].username = object
        
        do {
            try context?.save()
            print("Current user is", cUser[0].username!)
        } catch {
            print("Username not passed properly.")
        }
    }
    func deleteOneUser(username : String){
        let fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Account")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        do{
            let st = try context?.fetch(fetchReq)
            context?.delete(st?.first as! User)
            try context?.save()
            print("User deleted.")
        }
        catch{

        }
    }
}
