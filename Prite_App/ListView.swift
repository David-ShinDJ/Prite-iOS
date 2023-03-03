//
//  ListView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

class Model {
    let image:Image
    let data:Date
    let title: String
    let plot: String
    
    init(image: Image, data: Date, title:String, plot:String) {
        self.image = image
        self.data = data
        self.title = title
        self.plot = plot
    }
}

struct ListView: View {
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    @State private var randomeModels:[Model] = []
    @State private var upCounts:Int = 0
    @State private var downCounts:Int = 0
    @State private var upModels:[Model] = []
    @State private var downModels:[Model] = []

    
    let Rows = [GridItem(.flexible(maximum:400),spacing:0), GridItem(.flexible(maximum:400),spacing:0)]
    
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                if randomeModels.count == 0 {
                    Spacer()
                    Text("글을써서 리스트를 추가해주세요")
                        .font(.custom(font.titleFont, size: 24))
                    Spacer()
                } else {
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Rows,spacing:20) {
                            ForEach(0..<upCounts, id: \.self) { index in
                                NavigationLink {
                                    DetailView(model:upModels[index])
                                    }
                                label: {
                                    Text(upModels[index].title)
                                        .lineLimit(2)
                                        .font(.custom(font.plotFont, size: 24))
                                        .foregroundColor(theme.iconColor)
                                }
                                upModels[index].image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(30)
                                }
                            }
                        }
                    }
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: Rows,spacing:10) {
                            ForEach(0..<downCounts, id: \.self) { index in
                                NavigationLink {
                                    DetailView(model:downModels[index])
                                    }
                                label: {
                                    Text(downModels[index].title)
                                        .font(.custom(font.plotFont, size: 24))
                                        .foregroundColor(theme.iconColor)
                                }
                                downModels[index].image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(30)
                            }
                        }
                }
                Spacer()
                QuoteView(length: "long")
                    .font(.custom(font.plotFont, size: 24))
                Spacer()
            }
            .onAppear {
                var model:[Model] = []
                for i in 0...Int.random(in: 0...19) {
                    let newModel = Model(image: Image("trip\(i)"), data: Date(), title: "title\(i)", plot:"plot\(i)")
                    model.append(newModel)
                }
                self.randomeModels = model
                print(self.randomeModels.count)
                let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                let evenIndices = array.indices.filter { $0 % 2 == 0 }
                let evenValues = evenIndices.map { array[$0] }
                print(evenValues) // [1, 3, 5, 7, 9]
                
                let up = randomeModels.indices.filter{ $0 % 2 == 0}
                let upModel = up.map { randomeModels[$0]}
                self.upModels = upModel
                let down = randomeModels.indices.filter{ $0 % 2 == 1}
                let downModel = down.map { randomeModels[$0]}
                self.downModels = downModel
                self.upCounts = self.upModels.count
                self.downCounts = self.downModels.count
                
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
