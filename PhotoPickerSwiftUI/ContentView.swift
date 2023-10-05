//
//  ContentView.swift
//  PhotoPickerSwiftUI
//
//  Created by Onur Bulut on 4.10.2023.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var selectedItem : [PhotosPickerItem] = []
    @State var data : Data?
    
    
    var body: some View {
        VStack {
            if let data = data {
                if let selectedImage = UIImage(data: data){
                    Image(uiImage: selectedImage).resizable().frame(width: 300, height: 300)
                }
            }
            
            Divider()
            
            
            PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) {
                Text("Select Image")
            }.onChange(of: selectedItem) { image in
                guard let item = selectedItem.first else {
                    return
                }
                
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case . success(let data):
                        if let data = data {
                            self.data = data
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
