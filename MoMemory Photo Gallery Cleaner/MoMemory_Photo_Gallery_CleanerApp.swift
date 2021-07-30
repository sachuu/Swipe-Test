//
//  MoMemory_Photo_Gallery_CleanerApp.swift
//  MoMemory Photo Gallery Cleaner
//
//  Created by Sachintha Herath on 2021-06-26.
//

import Photos
import SwiftUI

var images = [PHAsset]()
//let readWriteStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)

func getImages() {
    let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
    assets.enumerateObjects({ (object, count, stop) in
       // self.cameraAssets.add(object)
        images.append(object)
    })

    //In order to get latest image first, we just reverse the array
    images.reverse()
}

@main
struct MoMemory_Photo_Gallery_CleanerApp: App {
    var body: some Scene {
        WindowGroup {
            MainMenuView().onAppear(){
                PHPhotoLibrary.requestAuthorization { (status) in
                    getImages()
                }
            }
        }
    }
}
