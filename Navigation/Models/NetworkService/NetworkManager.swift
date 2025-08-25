import Foundation

struct NetworkManager {
    static func request() {}
}

enum AppConfiguration: String, CaseIterable {
    // An SSL error has occurred and a secure connection to the server cannot be made
    case planet1 = "https://swapi.dev/api/planets/1"
    case planet2 = "https://swapi.dev/api/planets/2"
    case planet3 = "https://swapi.dev/api/planets/3"
    
    // This one works
    case testURL = "https://api.chucknorris.io/jokes/random"
    
    //iosdt-2
    case toDoListJSON = "https://jsonplaceholder.typicode.com/todos/"
    case planetsJSON = "https://swapi.py4e.com/api/planets/1/"
}

enum APIErrors: Error {
    case error(Error)
    case noData
    case noResponse
}

extension NetworkManager {
    
    // Iosdt - 1
    func request(for configuration: AppConfiguration, completition: ((Result<String, APIErrors>) -> Void)?) {
        let session = URLSession.shared
        let url = URL(string: configuration.rawValue)
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                completition?(.failure(.error(error!)))
                return
            }
            
            if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200 {
                print(urlResponse.statusCode)
                completition?(.failure(.noResponse))
                return
            }
            
            guard let data else {
                print("No Data")
                completition?(.failure(.noData))
                return
            }
            
            do {
                let message = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                
                // Error: An SSL error has occurred and a secure connection to the server cannot be made.
                //let messageText = "We are on \(message?["name"])\nthe climate here is: \(message?["climate"])"
                
                // This one works
                let messageText = message?["value"] as? String ?? "-"
                let urlResponse = response as! HTTPURLResponse
                
                print("All headers: ")
                print(urlResponse.allHeaderFields)
                print("++++++++++++++++++++++++++++++++++++++++++++++")
                
                print("Response status code: ")
                print(urlResponse.statusCode)
                print("++++++++++++++++++++++++++++++++++++++++++++++")
                               
                print("Parsed data:")
                completition?(.success(messageText))
            } catch {
                print("Parse error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
    // IOSDT-2
    func requestTodos(from url: AppConfiguration, completition: ((String) -> Void)?) {
        
        let session = URLSession.shared
        let url = URL(string: url.rawValue)
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200 {
                print("URL response error")
            }
            
            guard let data else {
                print("No data")
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            do {
                let message = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                let item = message[0]
                let title = item["title"] as! String
                completition?(title)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    // IOSDT-2
    func requestPlanets(from url: AppConfiguration, completition: ((Planet) -> Void)?) {
        
        let session = URLSession.shared
        let url = URL(string: url.rawValue)
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                print("Error != nil!")
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            if let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode != 200 {
                print("URL response error")
            }
            
            guard let data else {
                print("No data")
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            
            do {
                let message = try JSONDecoder().decode(Planet.self, from: data)
                completition?(message)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
}
