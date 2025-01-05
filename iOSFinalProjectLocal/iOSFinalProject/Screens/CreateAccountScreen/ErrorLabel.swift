import Foundation
import SwiftUI

struct ErrorLabel: View {
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(message).bold()
                    .foregroundStyle(.red)
                    .font(.system(size: FontSizes.errorMessageLabelSize.rawValue))
                Spacer()
            }
            }
        }
    }

#Preview {
    ErrorLabel(message: "Error message")
}
