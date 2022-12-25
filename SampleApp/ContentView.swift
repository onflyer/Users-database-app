//
//  ContentView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .padding()
            .onAppear {
                print("Users static data")
                dump(
                    try? StaticJSONMapper.decode(file: "UsersStaticData", type: UsersList.self)
                )
                print("Single user static data")
                dump(
                    try? StaticJSONMapper.decode(file: "SingleUserStaticData", type: UserDetailModel.self)
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
