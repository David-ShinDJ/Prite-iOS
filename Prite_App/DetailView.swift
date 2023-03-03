//
//  DetailView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/16.
//

import Foundation
import SwiftUI


struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    
    let model: Model
    
    @State private var title: String = ""
    @State private var plot: String = ""
    @State private var updating: Bool = false
    
    private func modify() {
        if updating {
            print(self.title, self.plot)
            self.presentationMode.wrappedValue.dismiss()
        } else {
            updating.toggle()
        }
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    model.image
                        .resizable()
                        .scaledToFill()
                    TextField("title", text:$title).disabled(!updating)
                        .padding()
                        .font(.custom(font.titleFont, size: 24))
                        .foregroundColor(theme.fontColor)
                    TextField("plot", text:$plot)
                        .disabled(!updating)
                        .padding()
                        .font(.custom(font.plotFont, size: 18))
                        .foregroundColor(theme.fontColor)
                    Spacer()
                    QuoteView(length: "long")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement:.navigationBarTrailing) {
                Button {
                    modify()
                } label: {
                    updating ? Text("수정완료") : Text("수정하기")
                }
            }
        }
    }
}
struct DetailView_Previews: PreviewProvider {
    static let model:Model = Model(image: Image("trip0"), data: Date(), title: "title", plot: "Plot")
    
    static var previews: some View {
        DetailView(model:model)
        
    }
}
