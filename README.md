# ![Title](https://i.imgur.com/gzOCOIc.png)  StacksManager

![Output sample](https://j.gifs.com/BN0ROJ.gif)

StacksManager framework works on an array of UIView objects stacked one over the other to provide a user friendly navigation over features that require multiple views to be presented in a sequential order. Each view is presented or dismissed according to the user actions.

IMPORTANT: Each view used in the stack must confirm to StackViewDataSource protocol.

There are two inbuilt user actions in this framework:

TapGesture : The user may tap on the next view, shown at the bottom of the screen, to move to that view. The user may tap on any other previously presented view to go back to that view. Tapping on current view will have no effect. Tapping while in the first view will not dismiss the entire stack.
EdgeSwipeGesture : The user may pan from the right edge of the screen to dismiss the current view. This gesture can be used to dismiss the entire stack, if done from the first visible view.


Data Passing:
 	Stack Manager has the capability to pass any value to the next view in the stack. This can be seen in the sample app while moving from StashAmountSelectionView to EMISelectionView, using methods sendDataToNextView() and recieveIncomingData(value: Any) methods.
The data passed in the sample app is hardcoded data for the purpose of demonstration.

View State:
The framework supports multiple view states. Dismiss, Visible, Background states are used in the sample app. If required, state FullScreen can be used too using the var state: ViewState { get set} which are available in the UIViews as part of confirming to StackViewDataSource protocol. These states can be used to change UI of each view as per app requirement. Navigating through the stack changes the state of the views as required (handled in StackManager internally).

StackManager only support portrait mode. 

