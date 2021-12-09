//
//  ChatPageViewModel.swift
//  ChatSwiftUI
//
//  Created by Apple on 11/30/21.
//

import Foundation
import Combine

class ChatPageViewModel: ObservableObject {
    @Published var chatUser: ChatUser
    @Published var chatText: String = ""
    @Published var messageError: String = ""
    @Published var chatMessages: [ChatMessage] = []
    @Published var count: Int = 0
    
    init(user: ChatUser) {
        self.chatUser = user
        fetchMessages()
    }
    
    func sendMessage() {
        guard let fromId  = FirebaseManager.shared.uid, chatText != "" else {return}
        let toId = chatUser.uid
        
        FirebaseManager.shared.saveMessageToFirestore(fromId: fromId, toId: toId, text: chatText, completion: { error in
            if let error = error {
                print("Saving message current user failed! \(error)")
                self.messageError = error
            }
            self.chatText = ""
            self.count += 1
        })
    }
    
    private func fetchMessages() {
        let toId = chatUser.uid
        guard let fromId = FirebaseManager.shared.uid, toId != "" else {return}
        FirebaseManager.shared.fetchMessages(fromId: fromId, toId: toId) { (result) in
            switch result {
            case .failure(let error):
                print("Fetch message error: \(error.localizedDescription)")
            case .success(let messages):
//                var tempChatMessage = messages
//                for i in 0..<tempChatMessage.count {
//                    if tempChatMessage[i].fromId == FirebaseManager.shared.uid {
//                        tempChatMessage[i].isMessageFromCurrentUser = true
//                    } else {
//                        tempChatMessage[i].isMessageFromCurrentUser = false
//                    }
//                }
                self.chatMessages = messages
            }
        }
    }
}
