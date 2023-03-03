//
//  WriteView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
// TODO: 이미지 않넣는경우 어떻게 작성될지 생각
struct WriteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @ObservedObject var proxyDatabase: ProxyDatabase
    @ObservedObject var locationManager: LocationManager = LocationManager()
    @State private var title:String = ""
    @State private var plot:String = "본문을 입력해주세요"
    @State private var isPresented = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var image:UIImage?
    
    init(proxyDatabase: ProxyDatabase, locationManager: LocationManager = LocationManager()) {
        self.proxyDatabase = proxyDatabase
        self.locationManager = locationManager
        locationManager.checkLocation()
    }
    
    var body: some View {
            VStack {
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
                            .foregroundColor(theme.iconColor)
                        Button {
                            self.isPresented.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(maxWidth: 48, maxHeight: 48)
                                .foregroundColor(theme.iconColor)
                        }.sheet(isPresented: $isPresented,onDismiss: {
                        },content: {
                            ImagePicker(sourceType: self.sourceType, image: $image)
                        })
                        Text("사진을 추가해주세요")
                            .font(.custom(font.titleFont, size:24))
                    }
                }
                HStack(spacing:10){
                    Text("제목")
                        .padding()
                        .font(.custom(font.titleFont, size:24))
                    Spacer()
                    TextField("제목을 입력해주세요", text: $title)
                        .font(.custom(font.titleFont, size:24))
                        .foregroundColor(theme.fontColor)
                        .onSubmit {
                        }
                }
                Divider()
                TextEditor(text: $plot)
                    .font(.custom(font.plotFont, size:18))
                    .foregroundColor(theme.fontColor)
                Button {
                    print(locationManager.region)
                } label: {
                    Text("좌표확인")
                }
                    .onTapGesture {
                       plot = ""
                    }
                if (title != "" && plot != "본문을 입력해주세요" && self.plot != "") {
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
