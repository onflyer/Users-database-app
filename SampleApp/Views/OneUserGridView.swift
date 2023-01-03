//
//  OneUserGridView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import SwiftUI

struct OneUserGridView: View {
    
    
    let user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                AsyncImage(url: .init(string: user.picture), content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                }, placeholder: {
                    ProgressView()
                })
                
                .padding()
                
            }
            .frame(width: 150, height: 150)
            Divider()
            Spacer()
            VStack(alignment: .leading) {
                Text("\(user.title.rawValue.capitalized)")
                Text("\(user.firstName)")
                Text("\(user.lastName)")
               
            }
            .foregroundColor(.primary)
            .frame(width: 200, height: 150, alignment: .leading)
            .font(.system(.title, design: .rounded, weight: .bold))
            
            
            
            
        }
        .frame(width: 360, height: 150)
        .background(Color.white)
        .cornerRadius(20)
    }
    
}



struct OneUserGridView_Previews: PreviewProvider {
    
    static var previewOneUser:User { //add computed property to show one user from the array
        let users = try! StaticJSONMapper.decode(file: "UsersStaticData", type: UsersList.self)
        return users.data.first!  // return first user
    }
    
    static var previews: some View {
        OneUserGridView(user: previewOneUser)
    }
}
