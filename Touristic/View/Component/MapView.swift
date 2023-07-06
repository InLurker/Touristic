//
//  MapView.swift
//  Touristic
//
//  Created by masbek mbp-m2 on 06/07/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Pura Ulun Danau Bratan"
        uiView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        uiView.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: -8.2760, longitude: 115.1628))
            .frame(height: 150)
            .cornerRadius(10)

    }
}
