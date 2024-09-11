//
//  CustomComponent.swift
//  Convercy
//
//  Created by Muhammad Dzaky on 11/09/24.
//

import Foundation
import SwiftUI


struct CustomComponentPreview : View {
    var body: some View {
        VStack{
            TextFieldDropdown()
        }.padding(24)
    }
}


struct TextFieldDropdown : View {
    var body: some View {
        @State var userInput : String = ""
        @State var selectedUnit : String = ""
        
        HStack {
            // TextField for user input
            TextField("Enter value", text: $userInput)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: .infinity)  // Adjust the width of the TextField
            
            // Picker for selecting unit, embedded in HStack next to the TextField
            Picker("", selection: $selectedUnit) {
                ForEach(ConversionType.LengthUnit.allCases, id: \.self) {
                    Text($0.rawValue).tag($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 92)
        }
    }
}

#Preview {
    CustomComponentPreview()
}
