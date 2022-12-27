//
//  CreateUserView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import SwiftUI

struct CreateUserView: View {
    
    @Environment(\.dismiss) private var dismiss  // for done to dissmis
    
    var body: some View {
        NavigationStack {
            Form {
                firstName
                lastName
                email
                
                
                Section {
                    submitButton
                }
            }
            .navigationTitle("Create User")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    doneButton

                }
                
            }        }
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}

private extension CreateUserView {
    
    var doneButton:some View {
        Button("Done") {
            dismiss() // fore done to dismiss
        }
    }
    
    var firstName: some View {
        TextField("First Name", text: .constant(""))
    }
    var lastName: some View {
        TextField("Last Name", text: .constant(""))
    }
    var email: some View {
        TextField("Email", text: .constant(""))
    }
    
    var submitButton: some View {
        Button("Submit") {
            // HANDLE LATER
        }
    }
}
