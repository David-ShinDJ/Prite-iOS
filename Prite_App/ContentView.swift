//
//  ContentView.swift
//  Prite_App
//
//  Created by David_ADA on 2023/02/13.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var coreLocation:CoreLocation = CoreLocation()
    @EnvironmentObject var proxyDatabase: ProxyDatabase
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    @State private var sourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var image:UIImage?
    
    var body: some View {
        VStack{
            Text("첫 글쓰기를 플레이어리에서 작성하려고합니다 지금 드는 생각을 글로 작성해주세요" + "\n" + "사진도 추가 할수있습니다")
                .font(.custom("SongMyung-Regular.ttf", size: 18))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.black)
                .padding()
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
                        .foregroundColor(.black)
                    Button {
                        self.isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(maxWidth: 48, maxHeight: 48)
                            .foregroundColor(.black)
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
            Spacer()
            HStack {
                Spacer()
                Button {
                    print(coreLocation.getCoordinate().latitude,coreLocation.getCoordinate().longitude)
                    print(coreLocation.locationManager?.location?.coordinate.latitude, coreLocation.locationManager?.location?.coordinate.longitude )
                } label: {
                    Text("작성완료")
                        .font(.custom("BlackHanSans-Regular.ttf", size: 24))
                        .padding()
                }.foregroundColor(.black)
            }
        }.onAppear {
            coreLocation.checkLocation()
            print(coreLocation.getCoordinate().latitude,coreLocation.getCoordinate().longitude)
            print(coreLocation.locationManager?.location?.coordinate.latitude, coreLocation.locationManager?.location?.coordinate.longitude )
        }
    }


}


//struct ContentView_Previews: PreviewProvider {
//    @StateObject var proxyDatabase:ProxyDatabase = ProxyDatabase()
//
//    static var previews: some View {
//        ContentView()
////        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
