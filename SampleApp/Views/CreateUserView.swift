//
//  CreateUserView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import SwiftUI

struct CreateUserView: View {
    
    @Environment(\.dismiss) private var dismiss  // for done to dissmis
    @FocusState private var focusedField: Field?
    @StateObject private var vm = CreateUserViewModel()
    let successfulAction: () -> Void // popover checkmark
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    firstName
                    lastName
                    email
                } footer: {  //extracting error descrtiption from formerror
                    if case .validation(let err) = vm.error,
                       let errorDesc = err.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                    
                }

                
                
                
                
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

extension CreateUserView {
    enum Field:Hashable {
        case firstName
        case lastName
        case email
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
            .focused($focusedField, equals: .firstName) // when user taps on firstname textfield ists going to assign .firstName vaue to focusField so system will know that focusedField is this textField so it can resign textField so its not active anymore (atribute errors)
    }
    var lastName: some View {
        TextField("Last Name", text: $vm.user.lastName)
            .focused($focusedField, equals: .lastName)
    }
    var email: some View {
        TextField("Email", text: $vm.user.email)
            .focused($focusedField, equals: .email)
    }
    
    var submitButton: some View {
        Button("Submit") {
            focusedField = nil // for removing atribute errors
            Task {
               await vm.create()
            }
           
        }
    }
}
