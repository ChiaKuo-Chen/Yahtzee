//
//  FirebaseModel.swift
//  Yahtzee
//
//  A service class for managing Firebase authentication and Firestore operations.
//  Handles anonymous login, player data synchronization, and leaderboard fetching.
//  This class abstracts all Firebase-related logic used in the Yahtzee app.
//
//  Created by 陳嘉國
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

// A manager responsible for interacting with Firebase Auth and Firestore.
class FirebaseModel {
    
    // Checks whether Firebase has already been configured in the app.
    //
    // - Returns: `true` if Firebase is initialized, otherwise `false`.
    func isFirebaseConfigured() -> Bool {
        return FirebaseApp.app() != nil
    }

    // Attempts to sign in anonymously using Firebase Authentication.
    // If already signed in, this will do nothing.
    func login() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    print("Login Failed: \(error.localizedDescription)")
                    return
                }
                // Login successful
            }
        } else {
            // Already logged in
        }
    }

    // Updates player data in Firestore with the provided values.
    //
    // - Parameters:
    //   - localUUID: Local device identifier for the player.
    //   - newName: Updated player name.
    //   - newScore: Updated player score.
    func updatePlayerData(localUUID: String?, newName: String?, newScore: Int?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        let docRef = db.collection("players").document(uid)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                var updateDict: [String: Any] = [:]
                let firebaseData = document.data() ?? [:]
                
                // Compare and update only the fields that have changed
                if let localUUID = localUUID,
                   (firebaseData["localUUID"] as? String) != localUUID {
                    updateDict["localUUID"] = localUUID
                }
                if let newName = newName,
                   (firebaseData["name"] as? String) != newName {
                    updateDict["name"] = newName
                }
                if let newScore = newScore,
                   (firebaseData["score"] as? Int) != newScore {
                    updateDict["score"] = newScore
                }

                if !updateDict.isEmpty {
                    updateDict["timestamp"] = Timestamp(date: Date())
                    docRef.setData(updateDict, merge: true)
                }

            } else {
                // Document doesn't exist – create new player data
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

    // Fetches the currently logged-in player's data from Firestore.
    //
    // - Parameter completion: A closure that returns a `Player` object or `nil` if not found.
    func fetchThisPlayer(completion: @escaping (Player?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }

        let db = Firestore.firestore()
        let docRef = db.collection("players").document(uid)

        docRef.getDocument { document, error in
            if let document = document, document.exists, let data = document.data() {
                let player = Player.from(data: data)
                completion(player)
            } else {
                completion(nil)
            }
        }
    }

    // Fetches the top 100 players from the Firestore leaderboard, sorted by score.
    //
    // - Parameter completion: A closure that returns an array of `Player` objects.
    func fetchLeaderboard(completion: @escaping ([Player]) -> Void) {
        let db = Firestore.firestore()

        db.collection("players")
            .order(by: "score", descending: true)
            .limit(to: 100)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Failed to fetch Firestore data: \(error.localizedDescription)")
                    completion([])
                    return
                }

                let players: [Player] = snapshot?.documents.compactMap { doc in
                    return Player.from(data: doc.data())
                } ?? []

                completion(players)
            }
    }
}
