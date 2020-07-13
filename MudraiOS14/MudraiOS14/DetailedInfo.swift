//
//  DetailedInfo.swift
//  MudraiOS14
//
//  Created by Aayush Pokharel on 2020-07-13.
//

import SwiftUI

struct DetailedInfo: View {
    var body: some View {
        
        VStack{
            Text("iPhone's Inner Api's Data is meant for developers and curious tinkers to see some insights as to what sensors iPhone has").font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            List{
            Text("Pitch, Yaw and Roll show Gyroscope data!")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Text("Magnetometer data refers to data shown by iPhone's built in 'magnnetic sensor")
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Text("Pressure and Attitude are self explanable")
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            Text("Notification Check Button Fire's up a notification 5 seconds after clicking it, make sure you have the app closed inorder for it to work.")
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
        }
        
        }.padding(.top, 50)
    }
}

struct DetailedInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailedInfo()
            .environment(\.sizeCategory, .large)
    }
}
