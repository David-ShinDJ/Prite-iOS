//
//  SerachView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/03/11.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    var onAdd = {}
    
    func onAdd(_ callback: @escaping () -> ()) -> some View {
        SearchView(onAdd:callback, searchViewModel: searchViewModel)
    }
    
    @StateObject var searchViewModel: SearchViewModel
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search ...", text: $searchViewModel.searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if searchViewModel.isEditing {
                                Button(action: {
                                    searchViewModel.searched = false
                                    searchViewModel.reset()
                                    searchViewModel.searchText = ""
                                    
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        searchViewModel.isEditing = true
                    }
                
                if searchViewModel.isEditing {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            searchViewModel.isEditing = false
                            self.onAdd()
                            // Dismiss the keyboard
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }) {
                        Text("Search")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                }
                }
            }
        }
}

class SearchViewModel: ObservableObject {
    
    @Published var searched:Bool = false
    @Published var searchText:String = ""
    @Published var isEditing = false

    func serach() {
        
    }
    
    func reset() {
        
    }
}
