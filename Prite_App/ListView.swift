//
//  ListView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

// Core Data 연결후 ScrollView 수정하기
struct ListView: View {
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Write.date, ascending: false)],
                  animation: .default)
    private var writes: FetchedResults<Write>
    
    // MARK: SearchBar 구현

    let Rows = [GridItem(.flexible(maximum:400),spacing:0), GridItem(.flexible(maximum:400),spacing:0)]
    
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                if writes.count == 0 {
                    Spacer()
                    Text("글을써서 리스트를 추가해주세요")
                        .font(.custom(font.titleFont, size: 24))
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
                                        .lineLimit(2)
                                        .font(.custom(font.plotFont, size: 24))
                                        .foregroundColor(theme.iconColor)
                                }
                                Image(uiImage: UIImage(data: writes[index].image!)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
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
                                        .lineLimit(2)
                                        .font(.custom(font.plotFont, size: 24))
                                        .foregroundColor(theme.iconColor)
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
                                    .lineLimit(2)
                                    .font(.custom(font.plotFont, size: 24))
                                    .foregroundColor(theme.iconColor)
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
                    .font(.custom(font.plotFont, size: 24))
                Spacer()
            }
            .onAppear {
                
            }
            .navigationBarHidden(true)
            .navigationTitle("리스트")
        }
    }
}

struct ListView_Previews: PreviewProvider {

    static var previews: some View {
        ListView()
    }
}
