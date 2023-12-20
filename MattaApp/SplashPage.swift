//
//  SplashPage.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 04/06/1445 AH.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .opacity(showSplash ? 1 : 0)
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                    )
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showSplash = false 
                    }
                }
            }
        }
    }
}
