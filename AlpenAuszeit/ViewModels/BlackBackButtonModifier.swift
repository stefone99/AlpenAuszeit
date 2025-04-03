import SwiftUI

// Vereinfachter ViewModifier, der NUR den Zurück-Pfeil schwarz macht
// ohne andere UI-Elemente zu beeinflussen
struct BlackBackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                            Text("Zurück")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
    }
}

// Erweiterung für eine einfachere Verwendung
extension View {
    func blackBackButton() -> some View {
        self.modifier(BlackBackButtonModifier())
    }
}
