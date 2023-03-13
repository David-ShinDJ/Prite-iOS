//
//  WriteView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/15.
//

import Foundation
import SwiftUI
// TODO: 맨위에 태그값이 이미지를 넣엇을떄 이미지클릭시 이미지변경이라고 안내가능하게 변화시키기
enum WriteError: Error {
    case emptyStringError
    case limitStringError
    case locationDefaultError
}
struct WriteView: View {
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @StateObject var coreLocationManager: CoreLocationManager
    @State private var title:String = ""
    @State private var plot:String = "본문을 입력해주세요"
    @State private var isPresented = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var image:UIImage?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func createWrite(success:Bool) {
        
        if success {
            let newWrite = Write(context: viewContext)
            newWrite.title = self.title
            newWrite.plot = self.plot
            newWrite.date = Date()
            newWrite.uuid = UUID()
            if image == nil {
                let randomNumber = Int.random(in: 0...20)
                newWrite.image = UIImage(named: "trip\(randomNumber)")?.jpegData(compressionQuality: 0.9)
            } else {
                newWrite.image = self.image?.jpegData(compressionQuality: 0.9)
            }
            newWrite.latitude = self.coreLocationManager.region.center.latitude
            newWrite.longitude = self.coreLocationManager.region.center.longitude
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            alertTitle = "생성완료"
            alertMessage = "생성된 글쓰기는 Writing에서 확인할수있습니다..."

            
        } else {
            print("Core Data 생성실패")
        }
    }
    
    func errorHandleWrite(completion: @escaping (Bool) -> Void) throws {
        if (title.isEmpty || plot.isEmpty ) {
            throw WriteError.emptyStringError
        }
        if (title.count <= 1 || plot.count <= 5)  {
            throw WriteError.limitStringError
        }
        if (self.coreLocationManager.region.center.latitude == Constants.defaultLocation.latitude || self.coreLocationManager.region.center.latitude == Constants.defaultLocation.longitude ) {
            throw WriteError.locationDefaultError
        }

        completion(true)
    
    }
    var body: some View {
            VStack {
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .onTapGesture {
                            self.isPresented.toggle()
                        }
                        .sheet(isPresented: $isPresented,onDismiss: {
                        },content: {
                            ImagePicker(sourceType: self.sourceType, image: $image)
                        })
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
                    .frame(height:2)
                    .overlay(theme.fontColor)
                TextEditor(text: $plot)
                    .font(.custom(font.plotFont, size:18))
                    .foregroundColor(theme.fontColor)
                if (title != "" && plot != "본문을 입력해주세요" && self.plot != "") {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showAlert = true
                            do {
                                try errorHandleWrite { success in
                                    createWrite(success: success)
                                }
                            } catch {
                                if error as! WriteError == WriteError.emptyStringError {
                                    alertTitle = "생성실패"
                                    alertMessage = "제목과 본문의 내용을 정확히 입력하세요..."
                                
                                } else if error as! WriteError == WriteError.limitStringError {
                                    alertTitle = "생성실패"
                                    alertMessage = "제목과 내용의 글자수가 너무작습니다..."
                                }
                                else if error as! WriteError == WriteError.locationDefaultError {
                                    alertTitle = "생성실패"
                                    alertMessage = "위치정보를 가져올수 없습니다..."
                                }
                            }
                        } label: {
                            Text("작성완료")
                                .padding()
                        }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(alertTitle),
                                message: Text(alertMessage),
                                dismissButton: .default(Text("확인")) {
                                    self.title = ""
                                    self.plot = ""
                                    self.image = nil
                                }
                            )
                        }
                    }
                }
            }
    }
}

