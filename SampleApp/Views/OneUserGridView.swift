//
//  OneUserGridView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import SwiftUI

struct OneUserGridView: View {
    
    let user:Int
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                Image(systemName: "person")
                    .resizable()
                    .padding()
                
            }
            .frame(width: 150, height: 150)
            Divider()
            Spacer()
            VStack(alignment: .leading) {
                Text("INFO")
                Text("INFO")
                Text("INFO")
                Text("INFO")
            }
            .frame(width: 200, height: 150, alignment: .leading)
            
        
                
        }
        .frame(width: 360, height: 230)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

struct OneUserGridView_Previews: PreviewProvider {
    static var previews: some View {
        OneUserGridView(user: 0)
    }
}
