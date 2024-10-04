import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var bookStore: BookStore
    @State private var name: String = "Jan Kowalski"
    @State private var bio: String = "iOS Developer"
    @State private var profileImage: String = "profile_image"
    @State private var backgroundImage: String = "background"
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .frame(height: UIScreen.main.bounds.height / 4)
            .overlay(
                
                VStack {
                    Image(profileImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .offset(y: UIScreen.main.bounds.height / 4 / 2)
                }
            )
            
            VStack {
                Text(name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 60)
                    .foregroundColor(.primary)
                
                Text(bio)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                VStack {
                    Text("Books Rented: \(bookStore.myBooks.count)")
                        .font(.headline)
                        .padding(.top, 16)

                    let finishedBooksCount = bookStore.myBooks.filter { $0.progress == $0.pages }.count
                    Text("Books Finished: \(finishedBooksCount)")
                        .font(.headline)
                        .padding(.top, 8)
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let bookStore = BookStore()
        return ProfileView()
            .environmentObject(bookStore)
    }
}
