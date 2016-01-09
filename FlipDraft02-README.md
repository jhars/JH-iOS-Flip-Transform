




		Current State: (README.md)
//-------------------------------//


Pods Installed:

pod 'iOS-Flip-Transform', '~> 0.0'
pod 'Firebase', '>= 2.5.0'
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
pod 'FBSDKShareKit'


Bridging Header:
...

#ifndef Bridge_Head_h
#define Bridge_Head_h

#import "iOS-Flip-Transform/FlipView.h"

	//*JH* REFER to: http://swiftalicio.us/2014/11/using-cocoapods-from-swift/

#endif /* Bridge_Head_h */

...

App Delegate:

import CoreData
import FBSDKCoreKit
import FBSDKLoginKit
	//*JH* REFER to: http://www.brianjcoleman.com/tutorial-facebook-login-in-swift/


Info.plist:
-includes Facebook Login Flow
- the order seems to matter a little bit, at least nesting arrays/keys properly. Fixed compilatioon errors when copy&pasted from a BSC Commit (I think a recent one..)
- Be Aware of Bundle Identifier






//==========================================//

//______________NOTES:____________//

//=> Segue after Facebook Login- more of a User Onboarding feature at this point.
		-> Should I Use SFSafariViewController?? -at least in-app probably
however,

//=> I do need Loading Screen- refer to Google API & BSC "Browse Sitters" flow

//=> Should I even consider iphone in design process? - or maybe that could just be the table view...?

//=> Think About Navigation Menu-Style (_=-=_)
	-> Hamburger? -- Probably Model after Flip Board

__________________________________________
Sprint #1 => DATA ARCHITECTURE


UserData INPUT & update FireBase API (account)
- Zip
- Email
- FireBase Account?
- Sitter (true or false)

 __________________________________________
 Sprint #2 => IMAGE From URL Loader (+ Data Display)

-Display User-Name in FlipVIew (direct from FireBase)
-Display Image in FlipView

__________________________________________
 Sprint #3 => UI/UX DESIGN

- Consider Muliple Device Sizes (this could mean I DESIGN in another Project in order to test for Display-Responsivness on smaller devices )
- Profile Layout
-'Browse Sitters' Layout
- Leave placeholders for -> Schedule, SMS insta-message

__________________________________________
 Sprint #4 => LIVE DATA IMPLEMENTATION

-Present Social Context Data
	+ (name, )

__________________________________________
 Sprint #4 => SITTER-View USER-INTERFACE

-add notes
-design based on Parent-View Design)


 __________________________________________
 Sprint #5 => Additional STRETCH Features

- Messages
- Weekly Schedule Optimizer


2nd Iteration Notes:








