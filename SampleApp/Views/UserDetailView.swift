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
            
            if vm.isLoading {
                ProgressView()
            }else {
                
                ScrollView {
                    VStack(alignment: .leading,spacing: 12) {
                        
                        avatarPicture
                        
                        Group {
                            generalInfo
                            linkInfo
                            detailInfo
                            locationInfo
                            
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical,6)
                        .background(Color(.systemFill), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                        
                        
                    }
                    .padding()
                }
            }
            
        }
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.fetchUserDetail(for: userId)
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
           let userURL = URL(string: urlFromJSON) {
            
            Link(destination: userURL) {
                
                VStack(alignment: .leading,spacing: 8) {
                    Text("Website")
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
    
    var detailInfo:some View {
        VStack(alignment: .leading,spacing: 8) {
            Group{
                genderDateOfBirthPhone
            }
            .foregroundColor(.primary)
            
        }
        
    }
    
    var locationInfo:some View {
        VStack(alignment: .leading,spacing: 8) {
            Group{
                location
            }
            .foregroundColor(.primary)
        }
    }
    
    @ViewBuilder
    var firstName:some View {
        Text("First Name:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.firstName ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
    }
    
    @ViewBuilder
    var lastName:some View {
        Text("Last Name:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.lastName ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
    }
    
    @ViewBuilder
    var email:some View {
        Text("Email:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.email ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
    }
    @ViewBuilder
    var location:some View {
        Text("Country:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.location.country ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
        Text("State:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.location.state ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
        Text("City:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.location.city ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Text("Street:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.location.street ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        
    }
    
    @ViewBuilder
    var genderDateOfBirthPhone:some View {
        Text("Gender:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.gender.capitalized ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
        Text("Date of Birth:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.dateOfBirth ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
        Divider()
        Text("Phone:")
            .font(.system(.body, design: .rounded,weight: .regular))
        Text(vm.userDetail?.phone ?? "-")
            .font(.system(.body, design: .rounded,weight: .semibold))
    }
    
    
}
