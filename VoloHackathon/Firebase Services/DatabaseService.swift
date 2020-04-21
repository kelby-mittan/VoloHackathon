//
//  DatabaseService.swift
//  VoloHackathon
//
//  Created by Kelby Mittan on 4/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    
    static let users = "users"
    static let posts = "posts"
    static let volunteers = "volunteers"
    static let interestedIn = "interestedIn"
    static let committedTo = "committedTo"
    
    private let db = Firestore.firestore()
    
    private init() {}
    static let shared = DatabaseService()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.users).document(authDataResult.user.uid).setData(["email" : email, "createdData": Timestamp(date: Date()), "userId": authDataResult.user.uid]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
            
        }
    }
    
    func updateDatabaseUser(name: String = "", userType: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        
        db.collection(DatabaseService.users).document(user.uid).updateData(["userType" : userType, "name": name]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
            
        }
        
    }
    
    public func fetchUserInfo(userId: String, completion: @escaping (Result<[User], Error>) -> ()) {
        db.collection(DatabaseService.users).whereField("userId", isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let items = snapshot.documents.map { User($0.data()) }
                completion(.success(items))
            }
        }
    }
    
    /*
     let id: String
     let description: String
     let shortDescription: String
     let location: String
     let category: String
     let startDate: Timestamp
     let endDate: Timestamp
     let status: String
     */
    
    public func addPost(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        db.collection(DatabaseService.posts).document(user.uid).setData(["id":post.id, "description" : post.description, "shortDescription" : post.shortDescription, "location": post.location, "category": post.category, "startDate": Timestamp(date: Date()), "endDate": Timestamp(date: Date()), "status": post.status, "email": email]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func addToInterests(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        db.collection(DatabaseService.users).document(user.uid).collection(DatabaseService.interestedIn).document(post.id).setData(["id":post.id, "description" : post.description, "shortDescription" : post.shortDescription, "location": post.location, "category": post.category, "startDate": Timestamp(date: Date()), "endDate": Timestamp(date: Date()), "status": post.status, "email": email]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func addToCommittments(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        db.collection(DatabaseService.users).document(user.uid).collection(DatabaseService.committedTo).document(post.id).setData(["id":post.id, "description" : post.description, "shortDescription" : post.shortDescription, "location": post.location, "category": post.category, "startDate": Timestamp(date: Date()), "endDate": Timestamp(date: Date()), "status": post.status, "email": email]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    /*
     let userId: String
     let name: String
     let location: String
     let imageURL: String
     let userType: String
     let verified: String
     */
    
    public func addVolunteer(volunteer: User, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        db.collection(DatabaseService.posts).document(user.uid).collection(DatabaseService.volunteers).document(volunteer.userId).setData(["userId":volunteer.userId, "name" : volunteer.name, "location" : volunteer.location, "imageURL": volunteer.imageURL, "userType": volunteer.userType, "verified": volunteer.verified, "email": email]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func fetchAllPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
        
        db.collection(DatabaseService.posts).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.compactMap { Post($0.data()) }
                completion(.success(posts.sorted{$0.endDate.seconds > $1.endDate.seconds}))
            }
        }
    }
    
    public func fetchAllUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        
        db.collection(DatabaseService.users).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let users = snapshot.documents.compactMap { User($0.data()) }
                completion(.success(users))
            }
        }
    }
    
    public func fetchInterests(completion: @escaping (Result<[Post], Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.users).document(user.uid).collection(DatabaseService.interestedIn).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.compactMap { Post($0.data()) }
                completion(.success(posts.sorted{$0.endDate.seconds > $1.endDate.seconds}))
            }
        }
    }
    
}
