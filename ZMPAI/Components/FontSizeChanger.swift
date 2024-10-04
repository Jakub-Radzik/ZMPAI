import SwiftUI

struct FontSizeChanger: View {
    @EnvironmentObject var bookStore: BookStore

    var body: some View {
        VStack {
            Button(action: {
                if bookStore.fontSize < 40 {
                    bookStore.fontSize += 1
                }
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding() // Add padding around the image
                    .frame(width: 50, height: 50) // Set a fixed width and height for the button
                    .background(Color.blue)
                    .clipShape(Circle()) // Make the button circular
            }
            
            Button(action: {
                if bookStore.fontSize > 8 {
                    bookStore.fontSize -= 1
                }
            }) {
                Image(systemName: "minus")
                    .foregroundColor(.white)
                    .padding() // Add padding around the image
                    .frame(width: 50, height: 50) // Set a fixed width and height for the button
                    .background(Color.blue)
                    .clipShape(Circle())
            }
        }
    }
}

