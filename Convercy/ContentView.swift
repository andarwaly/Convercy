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
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
        case kelvin = "Kelvin"
    }
}

struct ContentView: View {
    // Property Control
    @State private var selectedConversionType : ConversionType = .length
    @State private var inputLengthUnit : ConversionType.LengthUnit = .meters
    @State private var inputTempUnit : ConversionType.TempUnit = .celsius
    @State private var outputLengthUnit : ConversionType.LengthUnit = .feet
    @State private var outputTempUnit : ConversionType.TempUnit = .fahrenheit
    @State private var userInputValue : Double = 0
    
    // Variable to store converted value
    var convertedValue : Double {
        switch selectedConversionType {
        case .length:
            return convertLength(for: userInputValue, from: inputLengthUnit, to: outputLengthUnit)
        case .temperature:
            return convertTemperature(for: userInputValue, from: inputTempUnit, to: outputTempUnit)
        }
    }
    
   // Body View
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
                    .pickerStyle(.menu)
                case .temperature:
                    Picker("Convert to", selection: $outputTempUnit){
                        ForEach(ConversionType.TempUnit.allCases, id:\.self){
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Text(String(convertedValue))
            }
        }
    }
    
    // Fucntion Convert Length
    func convertLength (for value: Double, from: ConversionType.LengthUnit, to: ConversionType.LengthUnit) -> Double {
        let baseValue : Double // in meter
        
        // Convert to base value
        switch from {
        case .meters:
            baseValue = value
        case .kilometers:
            baseValue = value * 1000
        case .feet:
            baseValue = value * 0.3048
        case .yards:
            baseValue = value * 0.9144
        case .miles:
            baseValue = value * 1_609.344
        }
        
        // Convert base value to desired output
        switch to {
        case .meters:
            return baseValue
        case .kilometers:
            return baseValue / 1000
        case .feet:
            return baseValue / 0.3048
        case .yards:
            return baseValue / 0.9144
        case .miles:
            return baseValue / 1_609.344
        }
    }
    
    // Function Convert Temperature
    func convertTemperature(for value: Double, from: ConversionType.TempUnit, to: ConversionType.TempUnit) -> Double {
            // Convert `from` unit to Celsius first (base unit)
            let baseValue: Double // in celsius
            switch from {
            case .celsius:
                baseValue = value
            case .fahrenheit:
                baseValue = (value - 32) * 5 / 9
            case .kelvin:
                baseValue = value - 273.15
            }
            
            // Convert the base value (in Celsius) to the target `to` unit
            switch to {
            case .celsius:
                return baseValue
            case .fahrenheit:
                return baseValue * 9 / 5 + 32
            case .kelvin:
                return baseValue + 273.15
            }
        }
}

#Preview {
    ContentView()
}

