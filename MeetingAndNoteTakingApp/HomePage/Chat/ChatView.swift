//
//  ChatView.swift
//  MeetingAndNoteTakingApp
//
//  Created by Sümeyye Sert on 30.10.2024.
//

import SwiftUI

struct ChatView: View {
    
    @State private var searchUser: String = ""
    var users = ["user1", "user2", "user3", "user4"]
    
    var body: some View {
        NavigationView
        {
            VStack
            {
                TextField("arama", text: $searchUser)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                
                List {
                    ForEach(users, id: \.self) { user in
                        NavigationLink(destination: MessageView())
                        {
                            Text(user)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    ChatView()
}
