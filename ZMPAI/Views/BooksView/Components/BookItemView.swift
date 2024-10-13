import SwiftUI

struct BookItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let book: Book
    let geometry: GeometryProxy
    let isTwoColumnLayout: Bool

    var body: some View {
        if isTwoColumnLayout {
            VStack {
                Image(book.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: dynamicWidth(for: geometry.size.width),
                        height: dynamicHeight(for: geometry.size.height)
                    )
                    .clipped()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                Text(book.title)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(height: 20)
                    .padding(.top, 4)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(colorScheme == .dark ? Color(.darkGray) : Color.white)
            .cornerRadius(10)
        } else {
            // HStack layout for single-column view
            HStack {
                Image(book.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: dynamicWidth(for: geometry.size.width) * 0.8,
                        height: dynamicHeight(for: geometry.size.height) * 0.8
                    )
                    .clipped()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.top, 4)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text(book.author)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
        }
    }

    func dynamicWidth(for totalWidth: CGFloat) -> CGFloat {
        isTwoColumnLayout ? (totalWidth * 0.4) / 2 : totalWidth * 0.1
    }

    func dynamicHeight(for totalHeight: CGFloat) -> CGFloat {
        isTwoColumnLayout ? totalHeight * 0.2 : totalHeight * 0.1
    }
}
