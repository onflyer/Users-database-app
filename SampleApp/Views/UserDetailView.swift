//
//  UserDetailView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/26/22.
//

import SwiftUI

struct UserDetailView: View {
    
    @State private var userDetail:UserDetailModel? // ako nema neki podatak , da prikazemo "-"
    
    var body: some View {
        ZStack {
            backgroundColor
            
            ScrollView {
                VStack(alignment: .leading,spacing: 18) {
                    
                        avatarPicture
                    
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
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            do {
                userDetail = try StaticJSONMapper.decode(file: "SingleUserStaticData", type: UserDetailModel.self)
                
            } catch {
                    print(error)
                    
                }
            }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserDetailView()
        }
    }
}

private extension UserDetailView {
        var backgroundColor:some View {
            Color(.secondarySystemBackground)
                .edgesIgnoringSafeArea(.top)
        }
    
    @ViewBuilder
    var avatarPicture:some View {
        if let userPictureURLFromJSON = userDetail?.picture,
           let userPictureURL = URL(string: userPictureURLFromJSON) {
            
            AsyncImage(url: userPictureURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                    
                
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

        }
    }
    
    @ViewBuilder
    var linkInfo:some View {
        
        if let urlFromJSON = userDetail?.picture,
           let userURL = URL(string: urlFromJSON),
           let URLTitle = userDetail?.firstName {
           
            Link(destination: userURL) {
                
                VStack(alignment: .leading,spacing: 8) {
                    Text(URLTitle)
                        .foregroundColor(.primary)
                        .font(.system(.body, design: .rounded, weight: .semibold))
                        .multilineTextAlignment(.leading)
                    Text(urlFromJSON)
                        .scaledToFit()
                        
                }
                Spacer()
                
                Image(systemName: "link")
                    .font(.system(.title3,design: .rounded))
                
            }
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
        Text(userDetail?.firstName ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
    }
    
    @ViewBuilder
    var lastName:some View {
        Text(userDetail?.lastName ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text("<Last Name Here>")
        Divider()
    }
    
    @ViewBuilder
    var email:some View {
        Text("Email")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text(userDetail?.email ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
    }
}
