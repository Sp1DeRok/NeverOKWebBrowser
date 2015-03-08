//
//  AppDelegate.m
//  NeverOK
//
//  Created by Sp1DeR on 08.03.15.
//  Copyright (c) 2015 Sp1DeR App. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
   // Insert code here to initialize your application
   
   mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindow"];
   [mainWindowController showWindow:self];
   [mainWindowController addWebView:[NSURL URLWithString:@"http://www.google.com"]];
}

@end
