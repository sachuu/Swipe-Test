//
//  ContentView.swift
//  MoMemory Photo Gallery Cleaner
//
//  Created by Sachintha Herath on 2021-06-26.
//

import Photos
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack{
            //Top Stack
            HStack{
                Button(action:{}){
                    Image("profile")
                }
                Spacer()
                Button(action:{}){
                    Image("tinder-icon").resizable().aspectRatio(contentMode: .fit).frame(height:45)
                }
                Spacer()
                Button(action:{}){
                    Image("chats")
                }
            }.padding(.horizontal)
            //Actual Card
            ZStack{
                ForEach(Card.data){ card in
                    CardView(card: card).padding(8)
                }
            }.zIndex(1.0)
            //Bottom Stack
            HStack(spacing: 0){
                Button(action:{}){
                    Image("refresh")
                }
                Button(action:{}){
                    Image("dismiss")
                }
                Button(action:{}){
                    Image("super_like")
                }
                Button(action:{
                    print(images[0]);
                }){
                    Image("like")
                }
                Button(action:{}){
                    Image("boost")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getAssetThumbnail(asset: PHAsset) -> UIImage {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    manager.requestImage(for: asset, targetSize: CGSize(width: 500, height: 500), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
        thumbnail = result!
    })
    return thumbnail
}

//Card Structure
struct CardView: View{
    @State var card: Card
    let cardGradient = Gradient(colors: [Color.black.opacity(0), Color.black.opacity(0.5)])
    var body: some View{
        ZStack(alignment: .leading){
            Image(uiImage: getAssetThumbnail(asset: images[0])).resizable().padding(8)
            LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
            
            HStack {
                Image("yes").resizable().aspectRatio(contentMode: .fit).frame(width: 150).opacity(Double(card.x/10 - 1))
                Spacer()
                Image("nope").resizable().aspectRatio(contentMode: .fit).frame(width: 150).opacity(Double(card.x/10 * -1 - 1))
            }
        //ZStack follows the coordinates of the card model
        }.offset(x: card.x, y: card.y).rotationEffect(.init(degrees: card.degree)).gesture(
            //Gesture recognizer updates coordinate values
            DragGesture().onChanged { value in
                card.x = value.translation.width
                card.y = value.translation.height
                card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
            }
            //When user stops dragging
            .onEnded { value in
                withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)){
                        switch value.translation.width {
                            case 0...100:
                                card.x = 0; card.degree = 0; card.y = 0
                            //Keep (500)
                            case let x where x > 100:
                                card.x = 200; card.degree = 12
                            case (-100)...(-1):
                                card.x = 0; card.degree = 0; card.y = 0;
                            //Delete (500)
                            case let x where x < -100:
                                card.x = -200; card.degree = -12
                            default: card.x = 0; card.y = 0
                        }
                }
            }
        )
    }
}
