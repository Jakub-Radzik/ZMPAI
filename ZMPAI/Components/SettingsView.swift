import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var bookStore: BookStore
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Font Size Adjustment")) {
                    HStack {
                        Button(action: {
                            if bookStore.fontSize > 8 {
                                bookStore.fontSize -= 1
                            }
                        }) {
                            Image(systemName: "minus.circle")
                                .foregroundColor(.blue)
                        }
                        
                        Text("Font Size: \(Int(bookStore.fontSize))")
                            .font(.headline)
                            .padding()
                        
                        Button(action: {
                            if bookStore.fontSize < 40 {
                                bookStore.fontSize += 1
                            }
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let store = BookStore()
        return NavigationView{
            SettingsView()
                .environmentObject(store)
        }
    }
}
