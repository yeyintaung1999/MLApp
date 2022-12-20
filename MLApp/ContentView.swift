//
//  ContentView.swift
//  MLApp
//
//  Created by Ye Yint Aung on 16/12/2022.
//

import SwiftUI

struct ContentView: View {
    
    //Variables
    @ObservedObject var mlViewModel = MLViewModel()
    @State var isPresentedImagePicker : Bool = false
    @State var imageType: ImageType = .textDetect
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(named: "background")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "secondary")
    }
    
    var body: some View {
        TabView{
            //Text Detector View
            NavigationView{
                VStack(alignment: .center, spacing: 20){
                    CusZStackForImages(systemName: "photo", image: mlViewModel.imageTD)
                        .frame(height: 300)
                    Text(mlViewModel.text).frame(height: 200, alignment: .center)
                    CusButton(title: "Choose Photo", onTap: {
                        self.imageType = .textDetect
                        self.isPresentedImagePicker.toggle()
                    })
                    .sheet(isPresented: $isPresentedImagePicker) {
                        ImagePickerView(imageType: $imageType, isPresentedImagePicker: $isPresentedImagePicker, viewModel: self.mlViewModel)
                    }
                    CusButton(title: "Detect Text") {
                        mlViewModel.onTapDetectText()
                    }
                }
            }
            .tabItem {
                VStack{
                    Image(systemName: "text.viewfinder")
                    Text("Text Detector")
                }
                }
            //Face Detector View
            NavigationView{
                VStack(spacing: 20){
                    CusZStackForImages(systemName: "person.crop.artframe", image: mlViewModel.imageFD)
                    .frame(height: 400).padding([.leading,.trailing],20)
                    Spacer()
                    CusButton(title: "Choose Photo") {
                        self.imageType = .faceDetect
                        self.isPresentedImagePicker.toggle()
                    }
                    CusButton(title: "Detect Face", onTap: {
                        mlViewModel.onTapDetectFace()
                    })
                    .padding([.bottom], 30)
                }
            }
            .tabItem {
                VStack{
                    Image(systemName: "face.dashed")
                    Text("Face Detector")
                }
                
            }
            //Barcode Scanner View
            NavigationView{
                VStack(spacing: 20){
                    CusZStackForImages(systemName: "photo", image: mlViewModel.imageBC)
                        .frame(height: 200).padding([.leading,.trailing],20)
                    Spacer()
                    VStack(spacing: 30){
                        Text(mlViewModel.bcResult).font(.title)
                        HStack{
                            Image(systemName: "square.stack.3d.down.right")
                            Text("Copy")
                        }.onTapGesture {
                            UIPasteboard.general.string = mlViewModel.bcResult
                        }
                    }.frame(height: 160, alignment: .center)
                    CusButton(title: "Choose Photo") {
                        self.imageType = .barcodeScan
                        self.isPresentedImagePicker.toggle()
                    }
                    CusButton(title: "Scan Barcode") {
                        mlViewModel.onTapScanBarcode()
                    }
                    .padding([.bottom], 30)

                }
            }
            .tabItem {
                VStack{
                    Image(systemName: "barcode.viewfinder")
                    Text("Barcode Scanner")
                }
                
            }
        }
        .background(Color.init(uiColor: UIColor(named: "tint")!))
        .accentColor(Color.init(uiColor: UIColor(named: "tint")!))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
