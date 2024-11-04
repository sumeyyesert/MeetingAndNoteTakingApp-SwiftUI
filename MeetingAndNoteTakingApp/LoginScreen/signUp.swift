//
//  signUp.swift
//  MeetingAndNoteTakingApp
//
//  Created by Sümeyye Sert on 14.10.2024.
//

import SwiftUI
import FirebaseAuth

struct signUp: View {
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var confirmRegistiration = false
    @State private var confirmPasswordError: String = ""
    @State private var emailError: String = ""
    @State private var passwordError: String = ""

    var body: some View {
        
        NavigationStack {
            VStack (spacing: 8){
                
                Text("Kayıt Ol")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)
                
                CustomTexField(placeholder: "İsim", text: $name)
                CustomTexField(placeholder: "Soyisim", text: $surname)
                CustomTexField(placeholder: "Kullanıcı Adı", text: $username)
                CustomTexField(placeholder: "E-mail Adres", text: $email)
                if !emailError.isEmpty {
                    Text(emailError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 8)
                }
                CustomSecureField(placeholder: "Şifre", text: $password)
                if !passwordError.isEmpty {
                    Text(passwordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 8)
                }
                CustomSecureField(placeholder: "Şifre Tekrar", text: $confirmPassword)
                if !confirmPasswordError.isEmpty {
                    Text(confirmPasswordError)
                        .foregroundColor(.red)
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 8)
                }

                Button {
                    if passwordFormatCheck() && passwordRetypeCheck() && emailFormatCheck() {
                        self.confirmRegistiration.toggle()
                        register()
                    } else {
                        errorMessages()
                    }
                } label: {
                    Text("KAYIT OL")
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
                }
                .padding(.top, 20)

            }
            .navigationDestination(isPresented: $confirmRegistiration) {
                homePage()
                    .navigationBarBackButtonHidden(true)
            }
                
        }
    } //body bitiş
    
    func errorMessages() {

        if !emailFormatCheck() {
            emailError = "Geçerli bir e-mail adresi girin."
        }
        
        if !passwordFormatCheck() {
            passwordError = "Şifre en az 8 karakter, büyük/küçük harf, rakam ve özel karakter içermelidir."
        }
        
        if !passwordRetypeCheck() {
            confirmPasswordError = "Şifreler eşleşmiyor."
        }
        
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func passwordFormatCheck() -> Bool {
        var passwordFormatCheck: Bool = false
        
        let upperCaseLetter = self.password.rangeOfCharacter(from: CharacterSet.uppercaseLetters)
        let lowerCaseLetter = self.password.rangeOfCharacter(from: CharacterSet.lowercaseLetters)
        let digits = self.password.rangeOfCharacter(from: CharacterSet.decimalDigits)
        let specialCharacters = self.password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>?/`~"))
        
        if self.password.count >= 8 && upperCaseLetter != nil && lowerCaseLetter != nil && digits != nil && specialCharacters != nil {
            passwordFormatCheck.toggle()
        }
        return passwordFormatCheck
    }
    
    func passwordRetypeCheck() -> Bool {
        return self.password == self.confirmPassword
    }
    
    func emailFormatCheck() -> Bool {
        let validDomains = [".com", ".org", ".net", ".edu", ".gov", ".co", ".io", ".tech"]
        let emailFormat = self.email.split(separator: "@")
        if emailFormat.count == 2 {
            let domainPart = emailFormat[1]
            for domain in validDomains {
                if domainPart.hasSuffix(domain) {
                    return true
                }
            }
        }
        return false
    }
    
    struct CustomTexField: View {
        var placeholder: String
        @Binding var text: String 
        
        var body: some View {
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .cornerRadius(10)
                .autocapitalization(.none)
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
                .autocapitalization(.none)
                .textContentType(.none)
        }
    }
}

#Preview {
    signUp()
}
