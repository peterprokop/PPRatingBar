//
//  PPRBViewController.h
//  PPRatingBarController
//
//  Created by Petr Prokop on 2/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPRatingBar.h"

@interface PPRBViewController : UIViewController<PPRatingBarDelegate>
{
    PPRatingBar *_ratingBar;
    IBOutlet UIView *_ratingBarPlaceholder;
}

@end
