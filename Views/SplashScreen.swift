//
//  SplashScreen.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 14/04/22.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive:Bool = false
    @State var isLoading:Bool = false
    
    
//    @ObservedObject var favoritesViewModel:CompanyProfileModel
    var body: some View {
            ZStack {
                Color.gray.ignoresSafeArea().opacity(0.1)
                Spacer()
                if self.isActive {
                    if self.isLoading{
                        HomeView()
                    }
                    else{
                        ProgressView("Fetching Data")
                    }
                    
                }
                else {
                    Image("app icon")
                    .resizable()
                    .frame(width: 300, height: 300)
                    Spacer()
                    
                }
                
            }
            
        

            .onAppear {

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isLoading = true
                    }
                }
            }
        }
}

//struct SplashScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SplashScreen()
//    }
//}
