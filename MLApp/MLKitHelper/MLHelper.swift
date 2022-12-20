//
//  MLHelper.swift
//  MLApp
//
//  Created by Ye Yint Aung on 16/12/2022.
//

import Foundation
import MLKitVision
import MLKitTextRecognition
import UIKit
import MLKitFaceDetection
import MLKitBarcodeScanning

func getBarcodeScanner()->BarcodeScanner{
    let options = BarcodeScannerOptions(formats: .all)
    
    return BarcodeScanner.barcodeScanner(options: options)
}

func scanBarcode(image: UIImage, success: @escaping (String)->Void, failure: @escaping (String)->Void){
    let visionImage = VisionImage(image: image)
    visionImage.orientation = image.imageOrientation
    
    getBarcodeScanner().process(visionImage) { codes, error in
        
        var values: [String] = []
        
        guard error == nil, let codes = codes, !codes.isEmpty else {
            failure(error?.localizedDescription ?? "Invalid Codes")
            return
        }
        codes.forEach { code in
            values.append(code.displayValue ?? "Invalid Values")
        }
        
        success(values.joined(separator: "\n"))
    }
}

private let textRecognizer = TextRecognizer.textRecognizer()

func detectFace(image:UIImage, success: @escaping (UIImage)->Void, failure: @escaping (String)->Void){
    let visionImage = VisionImage(image: image)
    visionImage.orientation = image.imageOrientation
    
    
    FaceDetector.faceDetector().process(visionImage) { faces, error in
        
        if let error = error {
            failure(error.localizedDescription)
        } else {
            var drawnImage = image
            faces?.forEach { face in
                drawnImage = drawRectangleWithLine(image: image, rect: face.frame)
            }
            success(drawnImage)
        }
        
    }
    
}

func getFaceDetector()->FaceDetector{
    let option = FaceDetectorOptions()
    option.performanceMode = .accurate
    option.landmarkMode = .all
    option.classificationMode = .all
    
    return FaceDetector.faceDetector(options: option)
}

func detectText(image: UIImage, success: @escaping (UIImage, String)->Void, failure: @escaping(String)->Void){
    let visionImage = VisionImage(image: image)
    visionImage.orientation = image.imageOrientation
    textRecognizer.process(visionImage) { result, error in
        if let error = error {
            failure(error.localizedDescription)
        }else {
            var drawImage = image
            var stringArray : [String] = []
            
            result?.blocks.forEach({ block in
                drawImage = drawRectangleWithLine(image: image, rect: block.frame)
                stringArray.append(block.text)
            })
            success(drawImage, stringArray.joined(separator: "\n"))
        }
    }
}

func drawRectangleWithLine (image: UIImage, rect: CGRect)->UIImage {
    
    let imageSize = image.size
    let scale: CGFloat = 0
    UIGraphicsBeginImageContextWithOptions(imageSize, false, scale)
    
    let context = UIGraphicsGetCurrentContext()
    image.draw(at: CGPoint.zero)
    
    let rectangle = rect
    context?.setStrokeColor(UIColor.yellow.cgColor)
    context?.addRect(rectangle)
    context?.setLineWidth(3.0)
    context?.drawPath(using: .stroke)
    
    let drawImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    let newImage = drawImage ?? UIImage()
    return newImage
    
}

enum ImageType {
    case textDetect
    case faceDetect
    case barcodeScan
}
