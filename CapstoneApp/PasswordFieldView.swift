//
//  PasswordFieldView.swift
//  CapstoneApp
//
//  Created by 64001315 on 3/14/24.
//

import SwiftData
import SwiftUI

struct PasswordFieldView: View {
    @Binding var data: String
    var title: String?
    
    var body: some View {
        ZStack {
            SecureField("", text: $data)
                .padding(.horizontal, 10)
                .frame(height: 42)
                .overlay(RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .stroke(Color.gray, lineWidth: 1)
                )
                .autocapitalization(.none)
                .autocorrectionDisabled()
        HStack{
            Text(title ?? "Input")
                .font(.headline)
                .fontWeight(.thin)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .padding(4)
                .background(.white)
            Spacer()
            }
        .padding(.leading, 8)
        .offset(CGSize(width: 0, height: -20))
        }.padding()
    }
}

struct PasswordFieldView_Previews: PreviewProvider {
   @State static var data: String = ""
    
    static var previews: some View {
        PasswordFieldView(data: $data, title: "Password")
    }
}
