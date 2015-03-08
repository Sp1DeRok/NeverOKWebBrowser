//
//  MainWindowController.m
//  NeverOK
//
//  Created by Sp1DeR on 08.03.15.
//  Copyright (c) 2015 Sp1DeR App. All rights reserved.
//

#import "MainWindowController.h"
#import "BrowserView.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
   if (self = [super initWithWindow:window])
   {
      browserViews = [[NSMutableArray alloc] init];
   }
   
   return self;
}

- (void)windowDidLoad
{
   [super windowDidLoad];
   
   // Implement this method to handle any initialization after your window 
   // controller's window has been loaded from its nib file.
   
   // Remove all tab items
   for (NSTabViewItem *item in [tabView tabViewItems])
      [tabView removeTabViewItem:item];
   
   [tabView setAutoresizesSubviews:true];
   [searchField setDelegate:self];

   
   [tabBarControl setDelegate:self];
}

- (BrowserView *)addWebView:(NSURL *)url
{
   for (NSView *view in browserViews)
      [view setHidden:true];
   
   NSTabViewItem *tabViewItem = [[NSTabViewItem alloc] init];
   [tabViewItem setLabel:@"New Tab"];
   [tabView addTabViewItem:tabViewItem];
   [tabView selectTabViewItem:tabViewItem];
   
   BrowserView *browserView = [[BrowserView alloc] initWithFrame:mainView.frame];
   [browserView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
   [mainView addSubview:browserView];
   [browserViews addObject:browserView];
   
   [browserView setUIDelegate:self];
   [browserView setFrameLoadDelegate:self];
   
   if (url)
      [[browserView mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];
   
   return browserView;
}

- (void)controlTextDidEndEditing:(NSNotification *)notification
{   
   // See if it was due to a return
   if ( [[[notification userInfo] objectForKey:@"NSTextMovement"] intValue] == NSReturnTextMovement )
   {
      // Assume first subview of select tabViewItem view is browserView
      NSInteger index = [tabView indexOfTabViewItem:[tabView selectedTabViewItem]];
      BrowserView *browserView = browserViews[index];
      
      NSLog(@"Return was pressed!");
      NSString *text = [searchField stringValue];
      
      
      if ([text rangeOfString:@" "].location != NSNotFound) // spaces
      {
         text = [text stringByReplacingOccurrencesOfString:@" " withString:@"+"];

         text = [NSString stringWithFormat:@"%@%@", @"http://www.google.com/search?q=", text]; // Google
         [[browserView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:text]]];
      }
      else
      {
         if ([text hasPrefix:@"http://"] || [text hasPrefix:@"https://"])
            [[browserView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:text]]];
         else if ([text rangeOfString:@".com"].location != NSNotFound)
         {
            text = [NSString stringWithFormat:@"%@%@", @"http://", text];
            [[browserView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:text]]];
         }
         else
         {
            text = [text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
            
            text = [NSString stringWithFormat:@"%@%@", @"http://www.google.com/search?q=", text]; // Google
            [[browserView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:text]]];
         }
      }
   }
}

- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame
{

   NSTabViewItem *tabViewItem = nil;
   for (int i = 0; i < [browserViews count]; i++) // find tabViewItem relative to sender WebView
      if (browserViews[i] == sender)
         tabViewItem = [tabView tabViewItemAtIndex:i];
   
   [searchField setStringValue:[[frame webView] mainFrameURL]];
   [tabViewItem setLabel:[[frame webView] stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

// Method called when webView javascript requests new window with request
- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
   return [self addWebView:[request URL]];
}


- (IBAction)bookmarkButton:(NSButton*)sender
{
   BrowserView *browserView = [browserViews objectAtIndex:[tabView indexOfTabViewItem:[tabView selectedTabViewItem]]];
   [[browserView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[sender alternateTitle]]]];
}



// MMTabBarVievDelegate
- (void)tabView:(NSTabView *)aTabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem
{
   NSInteger index = [aTabView indexOfTabViewItem:tabViewItem];
   
   if ([browserViews count] > index)
   {
      for (NSView *view in browserViews)
         [view setHidden:true];
      
      BrowserView *browserView = browserViews[index];
      [browserView setHidden:false];
      
      [searchField setStringValue:[browserView mainFrameURL]];
      [tabViewItem setLabel:[browserView stringByEvaluatingJavaScriptFromString:@"document.title"]];
   }
}

- (void)tabView:(NSTabView *)aTabView didCloseTabViewItem:(NSTabViewItem *)tabViewItem
{
   NSInteger index = [aTabView indexOfTabViewItem:tabViewItem];
   
   if ([browserViews count] > index)
   {
      [browserViews removeObjectAtIndex:index];
   }
}



@end
