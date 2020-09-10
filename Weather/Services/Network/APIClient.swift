//
//  APIClient.swift
//  Weather
//
//  Created by Siarhei on 07.09.2020.
//  Copyright © 2020 Siarhei. All rights reserved.
//

import Foundation

class APIClient {
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, Error?) -> Void
    typealias ForecastWeatherCompletionHandler = (ForecastWeatherResponse?, Error?) -> Void

    private let apiKey = "e95731e15ed67e586247229181e06445"
    private let decoder = JSONDecoder()
    private let session: URLSession

    private enum SuffixURL: String {
        case forecastWeather = "forecast"
        case currentWeather = "weather"
    }
        
    private func baseUrl(_ suffixURL: SuffixURL, param: String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/\(suffixURL.rawValue)?APPID=\(self.apiKey)&units=metric\(param)")!
    }
        
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
        
    private func getBaseRequest<T: Codable>(at coordinate: Coordinate,
                                            suffixURL: SuffixURL,
                                            completionHandler completion:  @escaping (_ object: T?,_ error: Error?) -> ()) {
        
        let url = baseUrl(suffixURL, param: "&lat=\(coordinate.lat)&lon=\(coordinate.lon)")
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, ResponseError.requestFailed)
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        do {
                            let weather = try self.decoder.decode(T.self, from: data)
                            completion(weather, nil)
                        } catch let error {
                            print("error: \(error)")
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, ResponseError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        getBaseRequest(at: coordinate, suffixURL: .currentWeather) { (weather: CurrentWeather?, error) in
            completion(weather, error)
        }
    }
    
    func getForecastWeather(at coordinate: Coordinate, completionHandler completion: @escaping ForecastWeatherCompletionHandler) {
        getBaseRequest(at: coordinate, suffixURL: .forecastWeather) { (weather: ForecastWeatherResponse?, error) in
            completion(weather, error)
        }
    }
}
