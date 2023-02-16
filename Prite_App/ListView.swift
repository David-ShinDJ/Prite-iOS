//
//  ListView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

struct ListView: View {
    var dateString:String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: nowDate)
    }
    
    let basic_rows = [GridItem(.fixed(125),spacing: 0), GridItem(.fixed(125),spacing: 0)]
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: basic_rows, spacing:10) {
                        ForEach(0...mapdata.count - 1, id: \.self) { index in
                            NavigationLink {
                                DetailView(mapModel: mapdata[index])
                            } label: {
                                Text(mapdata[index].title)
                                    .frame(width:60, height:44)
                                
                            }
                            Image(uiImage: mapdata[index].image)
                                .resizable()
                                .frame(width:48, height:200)
                        }
                    }
                }
                ScrollView(.horizontal) {
                    LazyHGrid(rows: basic_rows,spacing: 10) {
                        ForEach(0...1, id: \.self) { value in
                            Rectangle()
                                .foregroundColor(.red)
                                .frame(width:60, height:44)
                            Rectangle()
                                .foregroundColor(.blue)
                                .frame(width:60, height:200)
                        }
                    }
                }
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
struct Ocean: Identifiable {
    let name: String
    let id = UUID()
}
