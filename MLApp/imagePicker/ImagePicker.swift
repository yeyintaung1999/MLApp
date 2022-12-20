//
//  ImagePicker.swift
//  MLApp
//
//  Created by Ye Yint Aung on 16/12/2022.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    let controller = UIImagePickerController()
    
    @Binding var imageType: ImageType
    
    @Binding var isPresentedImagePicker: Bool
    
    @ObservedObject var viewModel: MLViewModel
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent : ImagePickerView
        
        init(parent: ImagePickerView){
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as? UIImage
            switch parent.imageType {
                case .textDetect:
                    parent.viewModel.imageTD = image ?? UIImage()
                case .faceDetect:
                    parent.viewModel.imageFD = image ?? UIImage()
                case .barcodeScan:
                    parent.viewModel.imageBC = image ?? UIImage()
            }
            
            picker.dismiss(animated: true)
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
    }
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    
    
    
}
