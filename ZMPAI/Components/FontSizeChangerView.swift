import SwiftUI

struct FontSizeChangerView: View {
    @State private var fontSize: CGFloat = 16 // Initial font size

    var body: some View {
        VStack {
            Text("Change my font size!")
                .font(.system(size: fontSize)) // Use the dynamic font size
                .padding()

            HStack {
                Button(action: {
                    if fontSize > 8 { // Set a minimum font size
                        fontSize -= 1 // Decrease font size
                    }
                }) {
                    Text("-")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                Button(action: {
                    if fontSize < 40 { // Set a maximum font size
                        fontSize += 1 // Increase font size
                    }
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
    }
}

struct FontSizeChangerView_Previews: PreviewProvider {
    static var previews: some View {
        FontSizeChangerView()
    }
}
