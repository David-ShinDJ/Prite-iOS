//
//  WriteView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI

struct WriteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @ObservedObject var proxyDatabase: ProxyDatabase
    
    @State private var title:String = ""
    @State private var plot:String = "본문을 입력해주세요"
    @State private var isPresented = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var image:UIImage?
    
    
    var body: some View {
            VStack {
                Text("지금 내가 위치한곳을 생각하면서 글쓰기를 작성해봅시다")
                    .foregroundColor(theme.fontColor)
                    .font(.custom(font.titleFont, size: font.titleSize))
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                }
                else {
                    VStack {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(maxWidth: 48, maxHeight: 48)
                        Button {
                            self.isPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(maxWidth: 48, maxHeight: 48)
                        }.sheet(isPresented: $isPresented,onDismiss: {
                        },content: {
                            ImagePicker(sourceType: self.sourceType, image: $image)
                        })
                        Text("사진을 추가해주세요")
                            .font(.custom("BlackHanSans-Regular.ttf", size: 28))
                    }
                }
                HStack(spacing:10){
                    Text("제목")
                        .padding()
                    Spacer()
                    TextField("제목을 입력해주세요", text: $proxyDatabase.title)
                        .onSubmit {
                        }
                }
                Divider()
                TextEditor(text: $proxyDatabase.plot)
                    .font(.custom(font.plotFont, size: font.plotSize))
                    .onTapGesture {
                        self.plot = ""
                    }
                if self.title != "" && (self.plot != "본문을 입력해주세요" && self.plot != "") {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("작성완료")
                                .padding()
                        }
                    }
                }
            }
    }
}

struct WriteView_Previews: PreviewProvider {
    static var proxyDatabase:ProxyDatabase = ProxyDatabase()
    static var previews: some View {
        WriteView(proxyDatabase: proxyDatabase)
    }
}
