//
//  PPRBViewController.m
//  PPRatingBarController
//
//  Created by Petr Prokop on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PPRBViewController.h"


@implementation PPRBViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _ratingBar = [[PPRatingBar alloc] initWithFrame:_ratingBarPlaceholder.frame];
    [self.view addSubview:_ratingBar];
    _ratingBar.delegate = self;
    [_ratingBar release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - PPRatingBarDelegate

- (void) ratingBar:(PPRatingBar *) ratingBar 
   didChangeRating:(float) rating
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Rating changed!" 
                                                 message:[NSString stringWithFormat:@"%.1f", rating] 
                                                delegate:nil 
                                       cancelButtonTitle:@"OK" 
                                       otherButtonTitles:nil];
    [av show];
    [av release];
}

@end
