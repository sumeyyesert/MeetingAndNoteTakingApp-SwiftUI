//
//  signIn.swift
//  MeetingAndNoteTakingApp
//
//  Created by Sümeyye Sert on 14.10.2024.
//

import SwiftUI
import FirebaseAuth

struct signIn: View {
    @State var email: String = ""
    @State var password: String = ""
    @State private var confirmRegistiration = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Giriş Yap")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
                
                CustomTexField(placeholder: "E-mail Adresi", text: $email)
                CustomSecureField(placeholder: "Şifre", text: $password)
                
                NavigationLink(destination: signUp()) {
                    Text("Henüz bir hesabınız yok mu?")
                        .padding(.leading, 140) // sol tarafa 140 birim boşluk ekledik
                        .foregroundColor(.blue)
                }
                
                Button {
                    login()
                    
                } label: {
                    Text("GİRİŞ YAP")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 155/255, green: 89/255, blue: 182/255), // Parlak Mor
                                    Color(red: 0/255, green: 168/255, blue: 255/255)    // Neon Mavi
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                        .padding(.horizontal, 100)
                }.padding()
                .navigationDestination(isPresented: $confirmRegistiration) {
                    homePage()
                        .navigationBarBackButtonHidden(true)
                }
                
            }
        }
    }
    func login() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                confirmRegistiration.toggle()
            }
        }
    }
    
    struct CustomTexField: View {
        var placeholder: String
        @Binding var text: String
        
        var body: some View {
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
    
    struct CustomSecureField: View {
        var placeholder: String
        @Binding var text: String
        
        var body: some View {
            SecureField(placeholder, text: $text)
                .padding(10)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .disableAutocorrection(true)
                .textContentType(.none)
        }
    }

    
}

#Preview {
    signIn()
}
