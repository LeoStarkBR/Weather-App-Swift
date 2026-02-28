//
//  Service.swift
//  Weather App
//
//  Created by Leonardo Gabriel Gimenes
//

import Foundation

struct City {
    let lat: String
    let lon: String
    let name: String
}

class Service {
    
    private let baseURL: String = "https://api.openweathermap.org/data/2.5/onecall"
    private let apiKey: String = "bec639f861575fee21afb2957fa05c89"
    private let session = URLSession.shared
    
    func fecthData(city: City,
                   _ completion: @escaping (ForecastResponse?) -> Void) {

        let urlString =
        "\(baseURL)?lat=\(city.lat)&lon=\(city.lon)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

        let task = session.dataTask(with: url) { data, response, error in

            guard let data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }

            do {
                let forecastResponse =
                try JSONDecoder().decode(ForecastResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(forecastResponse)
                }

            } catch {
                print(error)
                print(String(data: data, encoding: .utf8) ?? "")
                DispatchQueue.main.async { completion(nil) }
            }
        }

        task.resume()
    }
    
}

struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let daily: [DailyForecast]
}

struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity
        case windSpeed = "wind_speed"
        case weather
    }
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
