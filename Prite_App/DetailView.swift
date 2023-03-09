//
//  DetailView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/16.
//

import Foundation
import SwiftUI

enum Field: Hashable {
    case title
    case plot
}
// TODO: CoreData Update & Delete
struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    
    @FocusState private var focusedField: Field?
    
    let write: Write
    @State private var title: String = ""
    @State private var plot: String = ""
    @State private var updating: Bool = false
    private func modify() {
        if updating {
            self.focusedField = .plot
            self.presentationMode.wrappedValue.dismiss()
        } else {
            updating.toggle()
        }
        
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Image(uiImage: UIImage(data: write.image!)!)
                        .resizable()
                        .scaledToFill()
                    TextField("제목", text:$title)
                        .focused($focusedField, equals: .title)
                        .padding()
                        .font(.custom(font.titleFont, size: 24))
                        .foregroundColor(theme.fontColor)
                        .disabled(!updating)
                    TextEditor(text:$plot)
                        .focused($focusedField, equals: .plot)
                        .padding()
                        .font(.custom(font.plotFont, size: 18))
                        .foregroundColor(theme.fontColor)
                        .disabled(!updating)
                        .aspectRatio(2.0, contentMode: .fill)
                    Spacer()
                    QuoteView(length: "long")
                        .font(.custom(font.titleFont, size: 18))
                }
                .onAppear {
                    self.title = write.title ?? "제목없음"
                    self.plot = write.plot ?? "본문없음"
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
