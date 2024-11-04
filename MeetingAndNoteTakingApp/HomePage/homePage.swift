//
//  homePage.swift
//  MeetingAndNoteTakingApp
//
//  Created by Sümeyye Sert on 15.10.2024.
//

import SwiftUI

struct homePage: View {
    var body: some View {
        
        NavigationStack
        {
            HStack(alignment: .top)
            {
                VStack(alignment: .listRowSeparatorLeading)
                {
                    NavigationLink(destination: ChatView()) {
                        CustomText(placeholder: "Sohbet")
                    }
                    
                    NavigationLink(destination: CalenderView()) {
                        CustomText(placeholder: "Takvim")
                    }
                    
                    NavigationLink(destination: NotesView()) {
                        CustomText(placeholder: "Notlar")
                    }
                    
                    NavigationLink(destination: ProjectManagementView()) {
                        CustomText(placeholder: "Proje Yönetimi")
                    }
                    
                    NavigationLink(destination: AppConnectionsView()) {
                        CustomText(placeholder: "Uygula Bağlama")
                    }
                } // vstack bitiş
                
                NavigationLink(destination: ProfileView()) {
                    CustomText(placeholder: "Profil")
                }

            } // hstack bitiş
            
        } // navigationstack bitiş
        
    } // body bitiş
    
    struct CustomText: View {
        var placeholder: String = ""
        
        var body: some View {
            Text(placeholder)
                .font(.title)
                .foregroundColor(Color.white)
                .padding(10)
                .background(Color(red: 0/255, green: 168/255, blue: 255/255))
                .cornerRadius(25)
                .frame(width: 205, height: 70)
        }
        
    }
    
}

#Preview {
    homePage()
}
