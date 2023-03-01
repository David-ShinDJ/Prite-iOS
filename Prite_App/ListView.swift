//
//  ListView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
let imageDatas: [Image] = Array(repeating: Image("trip0"), count: 20)
struct ListView: View {
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    @ObservedObject var proxyDatabase: ProxyDatabase
    
    
    
    var dateString:String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: nowDate)
    }
    
    let basic_rows = [GridItem(.flexible(maximum:400),spacing:0), GridItem(.flexible(maximum:400),spacing:0)]
    

    // TODO: 이진탐색 알고리즘 전체 데이터 // 2  나누어서 맨위왼쪽부터 채워넣어보자 위에 10개 아래 10개후 20개 넘어가는경우 오른쪽 아래부터 밀리게끔제작
    
    var body: some View {
        NavigationView {
            VStack(spacing:0) {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: basic_rows,spacing:20) {
                        ForEach(0...imageDatas.count / 2 - 1, id: \.self) { index in
                        NavigationLink {
//                                DetailView(mapModel: proxyDatabase.models[index])
                            }
                        label: {
                            Text(String(format: "Index : %D", Int(index)))
                                .lineLimit(2)
                                .foregroundColor(theme.buttonColor)
                                .font(.title3)
                        }
                            imageDatas[index]
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(30)
                        }
                    }
                }
                ScrollView(.horizontal) {
                    LazyHGrid(rows: basic_rows,spacing:10) {
                        ForEach(imageDatas.count / 2 ... imageDatas.count - 1, id: \.self) { index in
                            NavigationLink {
    //                                DetailView(mapModel: proxyDatabase.models[index])
                                }
                            label: {
                                Text(String(format: "Index : %D", Int(index)))
                                    .lineLimit(2)
                                    .foregroundColor(theme.buttonColor)
                                    .font(.title3)
                            }
                                imageDatas[index]
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(30)
                        }
                    }
                }
                Spacer()
                QuoteView(length: "long")
                    .font(.custom(font.plotFont, size: 24))
                Button {
                    print(imageDatas.count)
                } label: {
                    Text("데이터확인")
                }
                Spacer()
            }
            .navigationBarHidden(true)
            .navigationTitle("리스트")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var proxyDatabase:ProxyDatabase = ProxyDatabase()
    static var previews: some View {
        ListView( proxyDatabase: proxyDatabase)
    }
}
