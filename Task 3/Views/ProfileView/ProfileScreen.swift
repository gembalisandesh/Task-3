import SwiftUI
import Alamofire

struct ProfileScreen: View {
    @StateObject private var profileController = ProfileController(profile: Profile(name: "", age: "", gender: "", imaNumber: "", hospitalClinicName: "", experience: "", completeAddress: "", email: "", password: "", confirmPassword: "", profileImage: nil))
    @State private var isShowingImagePicker = false
    @State private var showingHomePage = false
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Let us know you better")
                    .font(.title)
                
                ProfileFormView(profileController: profileController, isShowingImagePicker: $isShowingImagePicker)
                Button(action: {
                    if profileController.profile.profileImage != nil &&
                        !profileController.profile.name.isEmpty &&
                        !profileController.profile.completeAddress.isEmpty &&
                        !profileController.profile.password.isEmpty &&
                        !profileController.profile.confirmPassword.isEmpty {
                        uploadProfile()
                    }
                    showAlert = true
                    showingHomePage = true
                }) {
                    Text("Let's Get Started")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }


            }
            .padding()
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(image: $profileController.profile.profileImage)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Incomplete Details"), message: Text("Please complete all details before proceeding."), dismissButton: .default(Text("OK")))
            }
        }
        .background(
            NavigationLink(
                destination: HomePageView(
                    profileImage: profileController.profile.profileImage ?? Image(systemName: "person.circle.fill"),
                    name: profileController.profile.name,
                    address: profileController.profile.completeAddress
                ),
                isActive: $showingHomePage
            ) {
                EmptyView()
            }
        )

        
        
    }
    
    private func uploadProfile() {
        guard let url = URL(string: "http://docapi.brokersaathi.co.in/api/User/UpdateUserProfilePic") else {
            print("Invalid URL")
            return
        }
        
        guard let uiImage = profileController.profile.profileImage?.asUIImage(size: CGSize(width: 100, height: 100)) else {
            print("Failed to convert SwiftUI Image to UIImage")
            return
        }
    
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else {
            print("Failed to convert image to data")
            return
        }
        
        var formData = MultipartFormData()
        formData.append(imageData, withName: "Images", fileName: "profileImage.jpg", mimeType: "image/jpeg")
        formData.append("\(profileController.profile.userId)".data(using: .utf8)!, withName: "UserId", fileName: "profileImage.jpg", mimeType: "image/jpeg")

       
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(formData.boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = formData.data
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
        }.resume()
    }
}
