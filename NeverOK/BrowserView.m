//
//  BrowserView.m
//  NeverOK
//
//  Created by Sp1DeR on 08.03.15.
//  Copyright (c) 2015 Sp1DeR App. All rights reserved.
//

#import "BrowserView.h"

@implementation BrowserView

- (id)initWithFrame:(NSRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      // Initialization code here.
      [self setCustomUserAgent:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36"];
      
      [self setShouldUpdateWhileOffscreen:true];
   }
   return self;
}

- (void)swipeWithEvent:(NSEvent *)event
{
   CGFloat x = [event deltaX];
   
   if (x != 0)
   {  
      x > 0 ? [self goForward] : [self goBack];
   }
}

@end
