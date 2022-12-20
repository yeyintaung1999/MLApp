//
//  uiComponents.swift
//  MLApp
//
//  Created by Ye Yint Aung on 16/12/2022.
//

import Foundation
import SwiftUI

struct CusButton: View {
    
    var title: String
    var onTap: ()->Void
    
    var body: some View {
        Button(title, action: onTap)
            .foregroundColor(Color.init(uiColor: UIColor(named: "background")!))
            .frame(width: 200, height: 40, alignment: .center)
            .background(Color.init(uiColor: UIColor(named: "secondary")!))
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.init(uiColor: UIColor(named: "background")!))
            }
    }
}

struct CusZStackForImages: View {
    var systemName: String
    var image: UIImage
    var body: some View {
        ZStack{
            Image(systemName: systemName)
                .opacity(0.4)
            
            Image(uiImage: image)
                .resizable()
                .opacity(1.0)
                .scaledToFit()
        }
    }
    
}

