import SwiftUI

struct SavedInfoView: View {
    @EnvironmentObject var userData: UserData
    @AppStorage("isOnboarded") private var isOnboarded: Bool = false
    @State private var showProfileView = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Your Info")
                .font(.title)

            Text("Username: \(userData.username)")
            Text("Email: \(userData.email)")
            Text("Zip Code: \(userData.zipCode)")
            Text("Hometown: \(userData.hometown)")

            Button("Continue to App") {
                isOnboarded = true
                showProfileView = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $showProfileView) {
            ProfileView().environmentObject(userData)
        }
        .padding()
    }
}
