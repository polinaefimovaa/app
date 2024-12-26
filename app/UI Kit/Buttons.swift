import SwiftUI

struct PrimaryButton: View {
    var text: String
    var body: some View {
        Text(text)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .font(.custom("TTHover-Regular", size: 20))
            .foregroundColor(.white)
            .background(Color.chorni)
            .padding(.vertical,16)
    }
}
