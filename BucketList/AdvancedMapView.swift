//
//  AdvancedMapView.swift
//  BucketList
//
//  Created by Aldiyar Batyrbekov on 6/19/20.
//  Copyright © 2020 Aldiyar B. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct AdvancedMapView: View {
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingAlert = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var errorAlert = false
    
    var body: some View {
        ZStack {
            if isUnlocked {
                AuthenticatedView(showingEditScreen: self.$showingEditScreen, showingPlaceDetails: self.$showingAlert, selectedPlace: self.$selectedPlace, locations: self.$locations)
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
            }
            
        }
        .onAppear(perform: loadData)
        .alert(isPresented: $showingAlert, content: {
            if errorAlert {
                return Alert(title: Text("Oops"), message: Text("Authentication failed"), dismissButton: .default(Text("Understood")) {
                    self.errorAlert = false
                    })
            } else {
                return Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Unknown"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                    })
            }
        })
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData, content: {
                if self.selectedPlace != nil {
                    EditView(placemark: self.selectedPlace!)
                }
            })
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
            print(locations)
        } catch {
            print("Unable to load saved data. \(error)")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch  {
            print("Unable to save data. \(error).")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate youresl to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingAlert = true
                        self.errorAlert = true
                    }
                }
            }
        } else {
            
        }
    }
}

struct AdvancedMapView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedMapView()
    }
}
