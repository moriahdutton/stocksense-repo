//
//  ContentView.swift
//  StockSense
//
//  Created by Moriah Dutton on 3/5/25.
//

/*import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
}*/
import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = false

    var body: some View {
        if isLoggedIn {
            MainAppView() // Replace with your main app view
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

struct MainAppView: View {
    var body: some View {
        Text("Welcome to StockSense!")
            .font(.largeTitle)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
