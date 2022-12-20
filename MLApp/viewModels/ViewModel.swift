//
//  ViewModel.swift
//  MLApp
//
//  Created by Ye Yint Aung on 16/12/2022.
//

import Foundation
import UIKit


class MLViewModel: ObservableObject {
    
    @Published var imageTD: UIImage = UIImage()
    @Published var imageFD: UIImage = UIImage()
    @Published var imageBC: UIImage = UIImage()
    @Published var text: String = "Hello! Welcome!"
    @Published var bcResult: String = ""
    
    func onTapDetectText(){
        detectText(image: imageTD) { image, string in
//            print("===>> Drawn Image Data ===> \(String(describing: image.pngData()))")
            self.imageTD = image
            self.text = string
        } failure: { msg in
            print(msg)
        }

    }
    
    func onTapDetectFace(){
        detectFace(image: imageFD) { image in
            //print("===> Success Image Data ==> \(String(describing: image.pngData()))")
            self.imageFD = image
        } failure: { msg in
            print(msg)
        }

    }
    
    func onTapScanBarcode(){
        scanBarcode(image: imageBC) { result in
            self.bcResult = result
            
        } failure: { msg in
            print("Fail to Scan Barcodes ==> \(msg)")
        }

    }
    
}
