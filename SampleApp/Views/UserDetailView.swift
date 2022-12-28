//
//  UserDetailView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/26/22.
//

import SwiftUI

struct UserDetailView: View {
    
    let userId:String // samo proslijedim id tip iz modela
    
    @StateObject private var vm = UserDetailViewModel()
    
   // @State private var userDetail:UserDetailModel? // ako nema neki podatak , da prikazemo "-" COMMENTED OUT WHEN WE ADDED @StateObject
    
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
            vm.fetchUserDetail(for: userId)
            }
        .alert(isPresented: $vm.hasError, error: vm.error) { }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    
    private static var previewUserId:String {  // pozovem local json i vratim id prvog iz arraya
        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersList.self)
        
        return users.data.first!.id
    }
    
    static var previews: some View {
        NavigationStack {
            UserDetailView(userId: previewUserId)  // proslijedim var koji sam kreirao da dobijem id prvog
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
        if let userPictureURLFromJSON = vm.userDetail?.picture,
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
        
        if let urlFromJSON = vm.userDetail?.picture,
           let userURL = URL(string: urlFromJSON),
           let URLTitle = vm.userDetail?.firstName {
           
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
        Text(vm.userDetail?.firstName ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
    }
    
    @ViewBuilder
    var lastName:some View {
        Text(vm.userDetail?.lastName ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text("<Last Name Here>")
        Divider()
    }
    
    @ViewBuilder
    var email:some View {
        Text("Email")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text(vm.userDetail?.email ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
    }
}
