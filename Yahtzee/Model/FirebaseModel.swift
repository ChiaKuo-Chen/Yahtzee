//
//  FirebaseModel.swift
//  Yahtzee
//
//  Created by 陳嘉國
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseModel {
    
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
    
    func updateScoreIfNeeded(newScore: Int, playerName: String) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let datemodel = DateModel()
        let db = Firestore.firestore()
        let docRef = db.collection("players").document(uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let oldScore = data?["score"] as? Int ?? 0
                
                if newScore > oldScore {
                    docRef.setData([
                        "name": playerName,
                        "score": newScore,
                        "timestamp": datemodel.getCurrentDateString(),
                    ], merge: true)
                    //print("Updated the Score")
                } else {
                    //print("No Need to Update.")
                }
            } else {
                // Firstime Save
                docRef.setData([
                    "name": playerName,
                    "score": newScore,
                    "timestamp": datemodel.getCurrentDateString(),
                ])
                //print("Create Player Data")
            }
        }
    }

    func fetchLeaderboard(completion: @escaping ([Player]) -> Void) {
        
        let db = Firestore.firestore()
        let datemodel = DateModel()

        db.collection("players")
            .order(by: "score", descending: true)
            .limit(to: 50)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to Fetch FirebaseStore：\(error.localizedDescription)")
                    completion([])
                    return
                }
                
                let players: [Player] = snapshot?.documents.compactMap { doc in
                    let data = doc.data()
                    return Player(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "Unknown",
                        score: data["score"] as? Int ?? 0,
                        timestamp: data["timestamp"] as? String ?? datemodel.getCurrentDateString()
                    )
                } ?? []
                
                completion(players)
            }
    }

}

