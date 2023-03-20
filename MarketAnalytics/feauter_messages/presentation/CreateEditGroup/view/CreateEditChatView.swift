//
//  CreateEditView.swift
//  MarketAnalytics
//
//  Created by Artur Andruszkiewicz on 09/02/2023.
//

import SwiftUI

struct CreateEditChatView: View {
    
    @StateObject private var vm: CreateEditChatViewModel = CreateEditChatViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vmNavigation: NavigationViewModel
    
    var title: String
    var idGroup: String?
    
    init(createGroup: Bool, idGroup: String? = nil) {
        title = createGroup ? "Create Group" : "Edit Group"
        self.idGroup = idGroup
    }
    
    var body: some View {
        ZStack {
            VStack {
                if vm.search == "" {
                    BottomBorderTextField(hint: "Group name...", isSecure: false, value: $vm.groupName)
                }
                
                if !vm.added.isEmpty {
                    HStack {
                        Text("Added people")
                            .font(.title2)
                            .padding()
                        Spacer()
                    }
                }
                
                ForEach(vm.added, id: \.self) { user in
                    HStack {
                        Text(user.userName)
                        Spacer()
                        Image(systemName: "minus")
                            .onTapGesture {
                                vm.removeFromGroup(user: user)
                            }
                    }
                    
                    if vm.notAdded.last != user {
                        Divider()
                    }
                }
                
                if !vm.notAdded.isEmpty {
                    HStack {
                        Text("Unadded people")
                            .font(.title2)
                            .padding()
                        Spacer()
                    }
                }
                
                ForEach(vm.notAdded, id: \.self) { user in
                    HStack {
                        Text(user.userName)
                        Spacer()
                        Image(systemName: "plus")
                            .onTapGesture {
                                vm.addToGroup(user: user)
                            }
                    }
                    
                    if vm.notAdded.last != user {
                        Divider()
                    }
                }
                
                if idGroup != nil {
                    CustomTextView(title: "Remove Group", isBorder: false)
                        .onTapGesture {
                            vm.removeGroup(idGroup: idGroup!) { isDeleted in
                                if isDeleted {
                                    vmNavigation.path.removeLast()
                                }
                            }
                        }
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                if idGroup == nil {
                    Image(systemName: "plus")
                        .onTapGesture {
                            vm.createGroup { createdGruop in
                                if createdGruop {
                                    dismiss()
                                }
                            }
                        }
                } else {
                    Image(systemName: "checkmark")
                        .onTapGesture {
                            vm.saveData(idGroup: idGroup!) { isSave in
                                if isSave {
                                    dismiss()
                                }
                            }
                        }
                }
            }
        })
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $vm.search, placement: .sidebar)
        .onAppear {
            if idGroup != nil {
                vm.loadData(idGroup: idGroup!)
            }
        }
    }
}
