import SwiftUI
import Foundation

struct API: Decodable {
    let name: String
    let barcode: Int
    let description: String
    let img: String
}
