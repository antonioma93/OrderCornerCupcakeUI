//
//  ContentView.swift
//  OrderCorner
//
//  Created by Massa Antonio on 17/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    @State private var username = ""
    @State private var email = ""
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        //        Form{
        //            Section{
        //                TextField("Username", text: $username)
        //                TextField("Email", text: $email)
        //            }
        //
        //            Section {
        //                Button("Create account") {
        //                    print("Creating account")
        //                }
        //            }
        //            .disabled(disableForm)
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 1...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
