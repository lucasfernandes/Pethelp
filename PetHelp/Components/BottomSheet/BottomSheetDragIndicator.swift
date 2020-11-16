import SwiftUI

struct BottomSheetDragIndicator: View {
    struct Defaults {
        static let dragIndicatorHeight: CGFloat = 5.3
        static let dragIndicatorWidth: CGFloat = 36
        static let dragIndicatorOpacity: Double = 0.45
    }

    var body: some View {
        RoundedRectangle(cornerRadius: BottomSheetDragIndicator.Defaults.dragIndicatorHeight/2)
            .fill(Color.gray)
            .opacity(BottomSheetDragIndicator.Defaults.dragIndicatorOpacity)
            .frame(width: BottomSheetDragIndicator.Defaults.dragIndicatorWidth, height: BottomSheetDragIndicator.Defaults.dragIndicatorHeight)
    }
}
