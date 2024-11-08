//
//  ProfileView.swift
//  MeetingAndNoteTakingApp
//
//  Created by Sümeyye Sert on 30.10.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack
        {
            VStack
            {
                Image("minus")
                    .resizable()
                    .clipShape(Circle())
                    .padding()
                
                Text("Sümeyye Sert")
                
            }
        }
    }
}

#Preview {
    ProfileView()
}
