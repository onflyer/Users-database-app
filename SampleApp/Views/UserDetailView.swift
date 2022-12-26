//
//  UserDetailView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/26/22.
//

import SwiftUI

struct UserDetailView: View {
    var body: some View {
        ZStack {
            backgroundColor
            
            ScrollView {
                VStack(alignment: .leading,spacing: 18) {
                    
                    Group {
                        generalInfo
                        linkInfo
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical,18)
                    .background(.white, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    
                }
                .padding()
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView()
    }
}

private extension UserDetailView {
        var backgroundColor:some View {
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.top)
        }
    
    var linkInfo:some View {
        Link(destination: .init(string: "https://randomuser.me/api/portraits/women/58.jpg")!) {
            
            VStack(alignment: .leading,spacing: 8) {
                Text("User URL")
                    .foregroundColor(.primary)
                    .font(.system(.body, design: .rounded, weight: .semibold))
                Text("https://randomuser.me/api/portraits/women/58.jpg")
                    .scaledToFit()
                    
            }
            Spacer()
            
            Image(systemName: "link")
                .font(.system(.title3,design: .rounded))
            
        }
    }
    }

private extension UserDetailView {
    
    var generalInfo:some View {
        VStack(alignment: .leading,spacing: 8) {
            Group{
                firstName
                lastName
                email
            }
            .foregroundColor(.primary)
            
        }
        
    }
    
    @ViewBuilder
    var firstName:some View {
        Text("First Name")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text("<First Name Here>")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
    }
    
    @ViewBuilder
    var lastName:some View {
        Text("Last Name")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text("<Last Name Here>")
        Divider()
    }
    
    @ViewBuilder
    var email:some View {
        Text("Email")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text("<Email here>")
            .font(.system(.body, design: .rounded,weight: .semibold))
    }
}
