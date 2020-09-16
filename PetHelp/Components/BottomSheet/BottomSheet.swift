import SwiftUI

public enum BottomSheetViewState {
    case closed
    case peek
    case half
    case full
}

@available(iOS 13.0, macOS 10.15, *)
public struct BottomSheet<Content>: View where Content: View {
    @EnvironmentObject var keyboardState: KeyboardState
    @GestureState private var gestureTranslation: CGFloat = 0
    @Binding private var viewState: BottomSheetViewState

    private var content: Content
    private var peekHeight: CGFloat = UIScreen.main.bounds.height * 0.175
    private var halfHeight: CGFloat = UIScreen.main.bounds.height * 0.47
    private var fullHeight: CGFloat = UIScreen.main.bounds.height

    private var frameHeight: CGFloat {
        get {
            if $keyboardState.isOpen.wrappedValue {
                return fullHeight - 200
            }
            return fullHeight
        }
    }

    private var offset: CGFloat {
        get {
            switch viewState {
            case .closed:
                return fullHeight
            case .peek:
                return fullHeight - peekHeight
            case .half:
                return fullHeight - halfHeight
            case .full:
                return 20
            }
        }
    }

    private func updateViewState(translationHeight: CGFloat) {
        if translationHeight < 0 {
            if self.viewState == .peek {
                self.viewState = .half
            } else {
                self.viewState = .full
            }
        } else {
            if self.viewState == .full {
                self.viewState = .half
            } else {
                self.viewState = .peek
            }
        }
    }

    public init(viewState: Binding<BottomSheetViewState>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._viewState = viewState
    }

    public var body: some View {
        VStack(spacing: 0) {
            BottomSheetDragIndicator()
                .padding(.top, 6)
                .padding(.bottom, 8)

            self.content
        }
        .frame(minHeight: peekHeight, maxHeight: fullHeight, alignment: .top)
        .background(Color("sheetBackground"))
        .cornerRadius(6)
        .shadow(color: Color("sheetShadow"), radius: 10, x: 0, y: 0)
        .offset(y: max(self.offset + self.gestureTranslation, 0))
        .animation(.interpolatingSpring(stiffness: 300.0, damping: 70.0, initialVelocity: 30.0))
        .gesture(
            DragGesture()
                .updating(self.$gestureTranslation) { value, state, _ in state = value.translation.height }
                .onEnded { value in self.updateViewState(translationHeight: value.translation.height) })
        .edgesIgnoringSafeArea(.bottom)
    }
}
