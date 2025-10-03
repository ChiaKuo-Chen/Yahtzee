//
//  FirebaseModel.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class FirebaseModel {
    
    func isFirebaseConfigured() -> Bool {
        return FirebaseApp.app() != nil
    }

    func login() {
        if Auth.auth().currentUser == nil {
            
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    print("Login Failed：\(error.localizedDescription)")
                    return
                }
                //print("Login Success，ID：\(result?.user.uid ?? "")")
            }
        } else {
            //print("Login Success，ID: \(Auth.auth().currentUser?.uid ?? "")")
        }
    }
    
    func updatePlayerData(localUUID: String?, newName: String?, newScore: Int?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        let docRef = db.collection("players").document(uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                var updateDict: [String: Any] = [:]
                let firebaseData = document.data() ?? [:]
                
                // localUUID
                if let localUUID = localUUID,
                   (firebaseData["localUUID"] as? String) != localUUID {
                    updateDict["localUUID"] = localUUID
                }
                
                // name
                if let newName = newName,
                   (firebaseData["name"] as? String) != newName {
                    updateDict["name"] = newName
                }
                
                // score
                if let newScore = newScore,
                   (firebaseData["score"] as? Int) != newScore {
                    updateDict["score"] = newScore
                }
                
                if !updateDict.isEmpty {
                    updateDict["timestamp"] = Timestamp(date: Date())
                    docRef.setData(updateDict, merge: true)
                    //print("Updated fields: \(updateDict.keys)")
                } else {
                    //print("No fields need update.")
                }
                
            } else {
                var newData: [String: Any] = [
                    "timestamp": Timestamp(date: Date())
                ]
                newData["localUUID"] = localUUID ?? UUID().uuidString
                newData["name"] = newName ?? "NewPlayer"
                newData["score"] = newScore ?? 0
                
                docRef.setData(newData, merge: true)
            }
        }
    }

    func fetchThisPlayer(completion: @escaping (Player?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }

        let db = Firestore.firestore()
        let docRef = db.collection("players").document(uid)

        docRef.getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                
                let timestamp: Date
                if let ts = data["timestamp"] as? Timestamp {
                    timestamp = ts.dateValue()
                } else {
                    timestamp = Date() // fallback
                }

                    let player = Player(
                        localUUID: data["localUUID"] as? String ?? "00000000-0000-0000-0000-000000000000",
                        name: data["name"] as? String ?? "Unknown",
                        score: data["score"] as? Int ?? 0,
                        timestamp: timestamp
                    )
                    completion(player)
            } else {
                completion(nil)
            }
        }
    }


    func fetchLeaderboard(completion: @escaping ([Player]) -> Void) {
        
        let db = Firestore.firestore()

        db.collection("players")
            .order(by: "score", descending: true)
            .limit(to: 100)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to Fetch FirebaseStore：\(error.localizedDescription)")
                    completion([])
                    return
                }
                
                let players: [Player] = snapshot?.documents.compactMap { doc in
                    let data = doc.data()
                    
                    let timestamp: Date
                    if let ts = data["timestamp"] as? Timestamp {
                        timestamp = ts.dateValue()
                    } else {
                        timestamp = Date()  // fallback
                    }

                    return Player(
                        localUUID: data["localUUID"] as? String ?? "00000000-0000-0000-0000-000000000000",
                        name: data["name"] as? String ?? "Unknown",
                        score: data["score"] as? Int ?? 0,
                        timestamp: timestamp
                    )
                } ?? []
                
                completion(players)
            }
    }
    

}

