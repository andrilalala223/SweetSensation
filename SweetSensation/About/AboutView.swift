//
//  AboutView.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        NavigationStack {
            ZStack {
                Background(bg: "bg1")
                
                ScrollView {
                    VStack {
                        
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image("exit")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 20)
                                    .padding(10)
                                    .background {
                                        Circle()
                                            .foregroundColor(.white)
                                    }
                            }
                            
                            
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        
                        StrokeText(text: "ABOUT US", width: 1.4, borderColor: .black, mainColor: .softPink)
                            .font(.system(size: 42, weight: .black, design: .rounded))
                            .padding(.vertical, -1)
                        
                        CarouselView()
                        
                        Text("""
At Sweet Sensations, we're dedicated to providing a wide array of mouthwatering sweets and treats, conveniently available at your fingertips.

From plain & fizzy sweets to bonbons, our curated selection ensures there's something for every sweet tooth.

Whether you're searching for a special gift, planning a party, or simply indulging yourself, we're committed to delivering the highest quality sweets and the best online shopping experience.

Join us in spreading sweetness across Europe, one delightful treat at a time!

Established in 2021.
""")
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .black))
                        .padding(.vertical, 40)
                        .padding(.horizontal, 30)
                        .background {
                            Image("recBlue")
                                .resizable()
                                .padding(.horizontal, -20)
                        }
                        .padding(.top)
                      
                        Spacer()
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    AboutView()
}


struct ImageItem: Identifiable {
    var id: Int
    var image: String
}

class CarouselViewModel: ObservableObject {
    @Published var items: [ImageItem]
    
    let images = ["1", "2", "3", "4"]
    
    init() {
        items = []
        for i in 0..<images.count {
            let new = ImageItem(id: i, image: images[i])
            items.append(new)
        }
    }
}


struct CarouselView: View {
    @StateObject var viewModel = CarouselViewModel()
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    var body: some View {
        
        ZStack {
            ForEach(viewModel.items, id: \.id) { item in
                
                Image(item.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .cornerRadius(12)
                    .scaleEffect(1.0 - abs(getdistance(item.id)) * 0.2 )
                    .opacity(1.0 - abs(getdistance(item.id)) * 0.3 )
                    .offset(x: getXOffset(item.id), y: 0)
                    .zIndex(1.0 - abs(getdistance(item.id)) * 0.1)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 100
                }
                .onEnded { value in
                    withAnimation {
                        draggingItem = snappedItem + value.predictedEndTranslation.width / 100
                        draggingItem = round(draggingItem).remainder(dividingBy: Double(viewModel.items.count))
                        snappedItem = draggingItem
                    }
                }
        )
    }
    
    func getdistance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(viewModel.items.count))
    }
    
    func getXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(viewModel.items.count) * getdistance(item)
        return sin(angle) * 240
    }
}
