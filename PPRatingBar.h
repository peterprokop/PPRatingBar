//  Created by Petr Prokop on 1/5/12.


#import <UIKit/UIKit.h>

@class PPRatingBar;

@protocol PPRatingBarDelegate <NSObject>

- (void) ratingBar:(PPRatingBar *) ratingBar 
   didChangeRating:(float) rating;

@end

@interface PPRatingBar : UIView
{
    UIImage *_onImage;
    UIImage *_offImage;
    UIImage *_halfImage;
    
    float _rating;
    NSMutableArray *_imageViews;
}

@property (assign, nonatomic) id<PPRatingBarDelegate> delegate;

- (void)updateRating;

@end
