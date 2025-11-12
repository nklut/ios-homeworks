import Foundation

struct Planet: Codable {
    var orbital_period: String
    var residents: [URL]
}

struct Resident: Codable {
    var name: String
}



