//
//  MainWindowController.h
//  NeverOK
//
//  Created by Sp1DeR on 08.03.15.
//  Copyright (c) 2015 Sp1DeR App. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MMTabBarView/MMTabBarView.h>
#import "BrowserView.h"

@interface MainWindowController : NSWindowController <NSTextFieldDelegate, NSToolbarDelegate, MMTabBarViewDelegate, NSMenuDelegate>
{
   IBOutlet NSTabView *tabView;
   IBOutlet MMTabBarView *tabBarControl;
   IBOutlet NSSearchField *searchField;
   IBOutlet NSView *mainView;
   
   NSMutableArray *browserViews;
}
- (BrowserView *)addWebView:(NSURL *)url;

@end
