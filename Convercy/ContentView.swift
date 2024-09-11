//
//  ContentView.swift
//  Convercy
//
//  Created by Muhammad Dzaky on 10/09/24.
//

import SwiftUI

// Enum for Conversion Types
enum ConversionType: String, CaseIterable {
    case length = "Length"
    case temperature = "Temperature"
    
    // Unit List
    enum LengthUnit: String, CaseIterable {
        case meters = "Meters"
        case kilometers = "Kilometers"
        case feet = "Feet"
        case yards = "Yards"
        case miles = "Miles"
    }
    
    enum TempUnit: String, CaseIterable {
        case celcius = "Celcius"
        case fahrenheit = "Fahrenheit"
        case kelvin = "Kelvin"
    }
}

struct ContentView: View {
    // Property Control
    @State private var selectedConversionType : ConversionType = .length
    @State private var inputLengthUnit : ConversionType.LengthUnit = .meters
    @State private var inputTempUnit : ConversionType.TempUnit = .celcius
    @State private var outputLengthUnit : ConversionType.LengthUnit = .meters
    @State private var outputTempUnit : ConversionType.TempUnit = .celcius
    @State private var userInputValue : Int?
    
    
    
    var body: some View {
        Form {
            Section {
                Picker("Conversion Type", selection: $selectedConversionType){
                    ForEach(ConversionType.allCases, id: \.self){
                        // type in Text(type.rawValue).tag(type) default syntax
                        Text($0.rawValue).tag($0) // shorthand syntax
                    }
                }
            }
            Section ("Your Value") {
                // Changes picker based on conversion type
                switch selectedConversionType {
                case .length:
                    Picker("Convert From", selection: $inputLengthUnit){
                        ForEach(ConversionType.LengthUnit.allCases, id:\.self){
                            Text($0.rawValue).tag($0)
                        }
                    }
                case .temperature:
                    Picker("Convert From", selection: $inputTempUnit){
                        ForEach(ConversionType.TempUnit.allCases, id:\.self){
                            Text($0.rawValue).tag($0)
                        }
                    }
                }
                TextField("Input Value", value: $userInputValue, format: .number)
            }
            Section ("Result"){
                switch selectedConversionType {
                case .length:
                    Picker("Convert to", selection: $outputLengthUnit){
                        ForEach(ConversionType.LengthUnit.allCases, id:\.self){
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                case .temperature:
                    Picker("Convert to", selection: $outputTempUnit){
                        ForEach(ConversionType.TempUnit.allCases, id:\.self){
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Text("This is your result")
            }
        }
    }
}

#Preview {
    ContentView()
}

