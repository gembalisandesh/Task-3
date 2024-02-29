import Foundation

struct MultipartFormData {
    private var formData: Data

    init() {
        formData = Data()
    }

    mutating func append(_ data: Data, withName name: String, fileName: String, mimeType: String){
        let boundary = "Boundary-\(UUID().uuidString)"
        let boundaryPrefix = "--\(boundary)\r\n"

        formData.append(boundaryPrefix.data(using: .utf8)!)
        formData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        formData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        formData.append(data)
        formData.append("\r\n".data(using: .utf8)!)
    }

    var data: Data {
        var finalData = formData
        finalData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return finalData
    }

    var boundary: String {
        return "Boundary-\(UUID().uuidString)"
    }
}
