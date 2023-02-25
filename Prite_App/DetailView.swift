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
    
    
    let mapModel: MapModel
    
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
            VStack(spacing: 10) {
                Image(uiImage: mapModel.image!)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 400, maxHeight: 240)
                    .border(.orange)
                    .clipped()
                TextField("title", text:$title).disabled(!updating)
                    .padding()
                TextField("plot", text:$plot)
                    .disabled(!updating)
                    .padding()
                Spacer()
            }
            .onAppear {
                self.title = mapModel.title!
                self.plot = mapModel.plot!
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
    static let data = MapModel(title:"모란시장", plot:"모란시장에서...", image:UIImage(named: "model0")!,latitude: 37.42917,longitude: 127.12710)
    
    static var previews: some View {
        DetailView(mapModel: data)
        
    }
}
