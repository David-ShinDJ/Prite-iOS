//
//  ListView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Write.date, ascending: false)],
                  animation: .default) private var writes: FetchedResults<Write>
    @State private var query = ""
    
    let Rows = [GridItem(.flexible(maximum:400),spacing:0), GridItem(.flexible(maximum:400),spacing:0)]
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                if writes.count == 0 {
                    Spacer()
                    Text("글을써서 리스트를 추가해주세요")
                        .foregroundColor(theme.fontColor)
                    Spacer()
                } else if writes.count <= 10 {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Rows,spacing:20) {
                            ForEach(0...writes.count - 1, id: \.self) { index in
                                NavigationLink {
                                    DetailView(write: writes[index])
                                    }
                                label: {
                                    Text(writes[index].title!)
                                        .foregroundColor(theme.accentColor)
                                        .lineLimit(2)
                                }
                                Image(uiImage: UIImage(data: writes[index].image!)!)
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .cornerRadius(30)
                                }
                            }
                        }
                    }
                else if writes.count > 10 {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Rows,spacing:20) {
                            ForEach(0...writes.count / 2 - 1,id: \.self) { index in
                                NavigationLink {
                                    DetailView(write: writes[index])
                                    }
                                label: {
                                    Text(writes[index].title!)
                                        .foregroundColor(theme.accentColor)
                                        .lineLimit(2)
                                }
                                Image(uiImage: UIImage(data: writes[index].image!)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(30)
                                }
                            }
                        }
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Rows,spacing:10) {
                            ForEach(writes.count / 2...writes.count - 1, id: \.self) { index in
                                NavigationLink {
                                    DetailView(write: writes[index])
                                    }
                            label: {
                                Text(writes[index].title!)
                                    .foregroundColor(theme.accentColor)
                                    .lineLimit(2)
                            }
                            Image(uiImage: UIImage(data: writes[index].image!)!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(30)
                            }
                        }
                }
                }
                Spacer()
                QuoteView(length: "long")
                    .font(.custom(font.serif, size: 18))
                Spacer()
            }
        }
        .searchable(text: $query, placement: .navigationBarDrawer(displayMode: .always), prompt: "제목과 본문을 검색하세요...")
        .onSubmit(of: .search) {
            writes.nsPredicate = NSPredicate(format: "title CONTAINS %@ OR plot CONTAINS %@", query, query)
        }
        .onChange(of: query) { value in
            if query.isEmpty && !isSearching {
                writes.nsPredicate = nil
            }
        }
    }
}



