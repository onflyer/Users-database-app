//
//  CreateUserView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import SwiftUI

struct CreateUserView: View {
    
    @Environment(\.dismiss) private var dismiss  // for done to dissmis
    @StateObject private var vm = CreateUserViewModel()
    let successfulAction: () -> Void // popover checkmark
    
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
            .disabled(vm.state == .submitting)
            .navigationTitle("Create User")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    doneButton

                }
                
            }
            .onChange(of: vm.state) { formState in
                if formState == .successfull {
                    dismiss()
                    successfulAction()
                }
                    
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { }
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
            }
            
        }
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView{}
    }
}

private extension CreateUserView {
    
    var doneButton:some View {
        Button("Done") {
            dismiss() // fore done to dismiss
        }
    }
    
    var firstName: some View {
        TextField("First Name", text: $vm.user.firstName)
    }
    var lastName: some View {
        TextField("Last Name", text: $vm.user.lastName)
    }
    var email: some View {
        TextField("Email", text: $vm.user.email)
    }
    
    var submitButton: some View {
        Button("Submit") {
            vm.create()
        }
    }
}
