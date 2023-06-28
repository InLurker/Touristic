//
//  APIGetter.swift
//  Touristic
//
//  Created by Jevin Laudo on 2023-06-27.
//

import Foundation
import SwiftUI


struct PlaceAdapter: Codable {
    let place_id: String
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    let interest: [String]
    let images: [String]
}

struct PlaceResponse: Codable {
    let success: Bool
    let message: String
    let data: [PlaceAdapter]
}

func getPlacesByInterest(completion: @escaping (Result<[PlaceAdapter], Error>) -> Void) {
    let url = URL(string: "https://touristic.masbek.my.id/api/get-place-by-interest")!
    let interests = ["I6", "I9", "I16", "I19"]
    let bodyData = try! JSONEncoder().encode(["interest_id": interests])
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = bodyData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "Response Data Error", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(PlaceResponse.self, from: data)
            completion(.success(response.data))
        } catch {
            completion(.failure(error))
        }    }.resume()
}

struct GetAPITest: View {
    @State private var places: [PlaceAdapter] = []
    
    var body: some View {
        VStack {
            Button(action: {
                getPlacesByInterest { result in
                    switch result {
                    case .success(let places):
                        self.places = places
                    case .failure(let error):
                        print(error)
                    }
                }
            }) {
                Text("test")
            }
            .buttonStyle(.borderedProminent)
            
            // Display the result
            List(places, id: \.place_id) { place in
                Text(place.name)
            }
        }
    }
}

struct getApiPreview: PreviewProvider {
    static var previews: some View {
        GetAPITest()
    }
}
