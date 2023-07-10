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
    let reviews: [ReviewAdapter]
    let avg_rating: String
    let prices: [Prices]
}

struct ReviewAdapter: Codable {
    let id: String
    let place_id: String
    let name: String
    let description: String
    let rating: Double
}

struct Prices : Codable {
    let id: String
    let place_id: String
    let type: String
    let price: String
}

struct PlaceListResponse: Codable {
    let success: Bool
    let message: String
    let data: [PlaceAdapter]
}

struct PlaceResponse: Codable {
    let success: Bool
    let message: String
    let data: PlaceAdapter
}

func getPlacesByInterest(interests: [String], completion: @escaping (Result<[PlaceAdapter], Error>) -> Void) {
    let url = URL(string: "https://touristic.masbek.my.id/api/get-place-by-interest")!
    let interests = interests
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
            let response = try decoder.decode(PlaceListResponse.self, from: data)
            completion(.success(response.data))
            
        } catch {
            completion(.failure(error))
        }
    }.resume()
}

func getPlaceById(place_id: String, completion: @escaping (Result<PlaceAdapter, Error>) -> Void) {
    let urlString = "https://touristic.masbek.my.id/api/get-place/\(place_id)"
    
    guard let url = URL(string: urlString) else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(PlaceResponse.self, from: data)
            completion(.success(result.data))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}


struct GetAPITest: View {
    @State private var place: PlaceAdapter? = nil
    
    var body: some View {
        VStack {
            Button(action: {
                getPlaceById(place_id: "P10") { result in
                    switch result {
                    case .success(let place):
                        self.place = place
                    case .failure(let error):
                        print(error)
                    }
                }
            }) {
                Text("test")
            }
            .buttonStyle(.borderedProminent)
            
            // Display the result
            Text(place?.name ?? "No name")
        }
    }
}

struct getApiPreview: PreviewProvider {
    static var previews: some View {
        GetAPITest()
    }
}
