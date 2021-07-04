//
//  ContentView.swift
//  AppOnboardingDesign
//
//  Created by Raphael Cerqueira on 02/07/21.
//

import SwiftUI

struct ContentView: View {
    var screenWidth = UIScreen.main.bounds.width
    @State var xOffset: CGFloat = 0
    @State var currentPage = 0
    var lastPage = data.count - 1
    var firstPage = 0
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(data) { item in
                        ItemView(item: item)
                            .frame(width: screenWidth)
                    }
                }
                .offset(x: xOffset)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            onChanged(value: value)
                        })
                        .onEnded({ value in
                            onEnded(value: value)
                        })
                    
                )
            }
            
            VStack(spacing: 20) {
                Spacer()
                
                ZStack {
                    HStack(spacing: 6) {
                        ForEach(0 ..< data.count + 1) { i in
                            Circle()
                                .frame(width: 6, height: 6)
                        }
                    }
                    .foregroundColor(.white)
                    
                    HStack(spacing: 6) {
                        ForEach(0 ..< data.count) { i in
                            if i == currentPage {
                                Capsule()
                                    .matchedGeometryEffect(id: "page", in: namespace)
                                    .frame(width: 18, height: 6)
                                    .animation(.default)
                            } else {
                                Circle()
                                    .frame(width: 6, height: 6)
                            }
                        }
                    }
                    .foregroundColor(.white)
                }
                
                ZStack {
                    if currentPage != lastPage {
                        HStack {
                            Button(action: {
                                currentPage = lastPage
                                withAnimation {
                                    xOffset = -screenWidth * CGFloat(currentPage)
                                }
                            }, label: {
                                Text("Skip")
                                    .frame(maxHeight: .infinity)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                currentPage += 1
                                withAnimation {
                                    xOffset = -screenWidth * CGFloat(currentPage)
                                }
                            }, label: {
                                HStack {
                                    Text("Next")
                                            
                                    Image(systemName: "arrow.right")
                                }
                                .font(.system(size: 17, weight: .bold))
                                .frame(maxHeight: .infinity)
                            })
                        }
                        .frame(height: 60)
                        .foregroundColor(.white)
                        
                    } else {
                        Button(action: {}, label: {
                            Text("Get started")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Capsule().fill(Color.white))
                        })
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        xOffset = value.translation.width - (screenWidth * CGFloat(currentPage))
    }
    
    func onEnded(value: DragGesture.Value) {
        if -value.translation.width > screenWidth / 2  && currentPage < lastPage {
            currentPage += 1
        } else {
            if value.translation.width > screenWidth / 2 && currentPage > firstPage {
                currentPage -= 1
            }
        }
        
        withAnimation {
            xOffset = -screenWidth * CGFloat(currentPage)
        }
    }
}

struct ItemView: View {
    var item: Item
    
    var body: some View {
        ZStack {
            item.backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top)
                
                VStack(spacing: 15) {
                    Text(item.title)
                        .font(.system(size: 40, weight: .semibold))
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                    
                    Text(item.subtitle)
                        .font(.system(size: 25, weight: .regular))
                        .multilineTextAlignment(.center)
                        .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
