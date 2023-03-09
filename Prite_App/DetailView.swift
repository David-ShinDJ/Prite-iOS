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

enum UpdateError: Error {
    case titleError
    case plotError
    case noUpdateError
}
// TODO: CoreData Update & Delete
struct DetailView: View {
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var deleteAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.environmentTheme) var theme: SettingTheme
    @Environment(\.environmentFont) var font: SettingFont
    @Environment(\.managedObjectContext) private var viewContext
    @FocusState private var focusedField: Field?
    @Environment(\.dismiss) private var dismiss
    let write: Write
    @State private var title: String = ""
    @State private var plot: String = ""
    @State private var updating: Bool = false
    
    
    private func updateWrite(success:Bool) {
        
        if success {
            let object = try? viewContext.existingObject(with:write.objectID)
            object?.setValue(self.title, forKey: "title")
            object?.setValue(self.plot, forKey: "plot")
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            alertTitle = "업데이트완료"
            alertMessage = "제목과 내용이 수정되었습니다..."
        } else {
            print("Core Data Update 실패")
        }
    }
    
    func errorHandleUpdate(completion: @escaping (Bool) -> Void) throws {
        
        if updating {
            focusedField = .title
        } else {
            updating.toggle()
        }
        if title.isEmpty || title.count < 1 {
            throw UpdateError.titleError
        }
        if plot.isEmpty || plot.count < 5 {
            throw UpdateError.titleError
        }
        if title == write.title && plot == write.plot {
            throw UpdateError.noUpdateError
        }
        completion(true)
    }
    
    private func deleteWrite() {
        let object = try? viewContext.existingObject(with:write.objectID)
        do {
            print("deleted \(object!)")
            viewContext.delete(object!)
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Image(uiImage: (UIImage(data: write.image ?? Data()) ?? UIImage(named: "trip3"))!)
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
                    if updating {
                        Button {
                            deleteAlert = true
                        } label: {
                            Text("글쓰기삭제")
                                .foregroundColor(.red)
                        }                    .alert(isPresented:$deleteAlert) {
                            Alert(
                                title: Text("정말로 삭제 하시겠습니까??"),
                                message: Text("계정삭제시 복구불가"),
                                primaryButton: .destructive(Text("삭제")) {
                                    dismiss()
                                    deleteWrite()
                                },
                                secondaryButton: .cancel())
                        }

                    }
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
                    showAlert = updating
                    do {
                        try errorHandleUpdate { success in
                            updateWrite(success: success)
                        }
                    } catch {
                        if error as! UpdateError == UpdateError.titleError {
                            alertTitle = "업데이트실패"
                            alertMessage = "제목의 수정에 실패했습니다..."
                        
                        } else if error as! UpdateError == UpdateError.plotError {
                            alertTitle = "업데이트실패"
                            alertMessage = "본문내용의 수정에 실패했습니다..."
                        }
                        else if error as! UpdateError == UpdateError.noUpdateError {
                            alertTitle = "업데이트실패"
                            alertMessage = "업데이트된곳이없습니다..."
                        }
                    }
                } label: {
                    updating ? Text("수정완료") : Text("수정하기")
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("확인")) {
                        }
                    )
                }
            }
        }
    }
}
