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
    static let chats = "chats"
    static let threads = "threads"
  
  private var docRef : DocumentReference?
    
    private let db = Firestore.firestore()
    
    private init() {}
    static let shared = DatabaseService()
    
    public func createDatabaseUser(authDataResult: AuthDataResult, userType: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.users).document(authDataResult.user.uid).setData(["email" : email, "createdData": Timestamp(date: Date()), "userId": authDataResult.user.uid, "userType": userType]) { (error) in
            
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
        
        
        db.collection(DatabaseService.posts).document(post.postId).setData(["orgId":post.orgId, "description" : post.description, "shortDescription" : post.shortDescription, "location": post.location, "category": post.category, "startDate": post.startDate, "postDate": Timestamp(date: Date()), "status": post.status, "email": email, "postId": post.postId, "imageURL": post.imageURL]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    public func addToInterests(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        db.collection(DatabaseService.users).document(user.uid).collection(DatabaseService.interestedIn).document(post.postId).setData(["orgId":post.orgId, "description" : post.description, "shortDescription" : post.shortDescription, "location": post.location, "category": post.category, "startDate": post.startDate, "postDate": Timestamp(date: Date()), "status": post.status, "email": email, "imageURL": post.imageURL]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
//    public func addToCommittments(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
//        
//        guard let user = Auth.auth().currentUser, let email = user.email else { return }
//        
//        db.collection(DatabaseService.users).document(user.uid).collection(DatabaseService.committedTo).document(post.id).setData(["id":post.id, "description" : post.description, "shortDescription" : post.shortDescription, "location": post.location, "category": post.category, "startDate": post.startDate, "postDate": Timestamp(date: Date()), "status": post.status, "email": email]) { (error) in
//            
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                completion(.success(true))
//            }
//        }
//    }
    
    /*
     let userId: String
     let name: String
     let location: String
     let imageURL: String
     let userType: String
     let verified: String
     */
    
    public func addVolunteer(post: Post, volunteer: User, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let user = Auth.auth().currentUser, let email = user.email else { return }
        
        db.collection(DatabaseService.posts).document(post.postId).collection(DatabaseService.volunteers).document(volunteer.userId).setData(["userId":volunteer.userId, "name" : volunteer.name, "location" : volunteer.location, "imageURL": volunteer.imageURL, "userType": volunteer.userType, "verified": volunteer.verified, "email": email]) { (error) in
            
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
                completion(.success(posts.sorted{$0.postDate.seconds > $1.postDate.seconds}))
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
                completion(.success(posts.sorted{$0.postDate.seconds > $1.postDate.seconds}))
            }
        }
    }
    
    public func fetchVolunteers(post: Post, completion: @escaping (Result<[User], Error>) -> ()) {
      db.collection(DatabaseService.posts).document(post.postId).collection(DatabaseService.volunteers).getDocuments { (snapshot, error) in
        if let error = error {
          completion(.failure(error))
        } else if let snapshot = snapshot {
          let users = snapshot.documents.compactMap { User($0.data())}
          completion(.success(users))
        }
      }
    }
  
  public func createNewChat(user1ID: String, user2ID: String, completion: @escaping (Result<Bool, Error>) -> ()) {
    let users = [user1ID, user2ID]
    let data: [String: Any] = [DatabaseService.users: users]
        
    db.collection(DatabaseService.chats).addDocument(data: data) { (error) in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(true))
      }
    }
  }
  
  public func loadChats(user1ID: String, user2ID: String, completion: @escaping (Result<Chat, Error>) -> ()) {
    db.collection(DatabaseService.chats).whereField(DatabaseService.users, arrayContains: user1ID).getDocuments { (snapshot, error) in
      if let error = error {
        completion(.failure(error))
      } else if let snapshot = snapshot {
        for doc in snapshot.documents {
          if let chat = Chat(dictionary: doc.data()) {
          if (chat.users.contains(user2ID)) {
            self.docRef = doc.reference
            let docReference = doc.reference
            docReference.collection(DatabaseService.threads).order(by: "created", descending: false)
          }
          completion(.success(chat))
          }
        }
      }
    }
  }
  
  public func saveChatMessage(_ message: Message, user1ID: String, user2ID: String, completion: @escaping (Result <Bool, Error>) -> ()) {
      let data: [String: Any] = ["content": message.content,
                                 "created": message.created,
                                 "id": message.id,
                                 "senderID": message.senderID,
                                 "senderName": message.senderName]
      
    docRef?.setData(data, completion: { (error) in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(true))
      }
    })
  }
  
  public func chatsAvailable(userID: String, completion: @escaping (Result <[Chat], Error>) -> ()) {
    db.collection(DatabaseService.chats).whereField(DatabaseService.users, arrayContains: userID).getDocuments { (snapshot, error) in
      var chatArray = [Chat]()
      if let error = error {
        completion(.failure(error))
      } else if let snapshot = snapshot {
        for doc in snapshot.documents {
          if let chat = Chat(dictionary: doc.data()) {
            chatArray.append(chat)
          completion(.success(chatArray))
          }
        }
      }
    }
  }
  
}
