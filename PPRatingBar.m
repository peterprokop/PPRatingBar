//  Created by Petr Prokop on 1/5/12.

#import "PPRatingBar.h"

//define number of stars to show (and maximum rating user can give)
#define kNumberOfStars 6

@implementation PPRatingBar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        _rating = 0.0f;
        
        _onImage = [UIImage imageNamed:@"starBig.png"];
        _offImage = [UIImage imageNamed:@"starBigOff.png"];
        _halfImage = [UIImage imageNamed:@"starBigHalf.png"];
        
        CGFloat spaceBetweenStars = (frame.size.width - _offImage.size.width*kNumberOfStars)/(kNumberOfStars+1);
        _imageViews = [[NSMutableArray alloc] initWithCapacity:5];
        
        for(NSInteger i=0; i<kNumberOfStars; i++)
        {
            UIImageView *iv = 
            [[UIImageView alloc] initWithFrame:CGRectMake((_offImage.size.width + spaceBetweenStars)*i + spaceBetweenStars, 
                                                          (frame.size.height - _offImage.size.height)/2, 
                                                          _offImage.size.width, 
                                                          _offImage.size.height)];
            iv.image = _offImage;
            [self addSubview:iv];
            [_imageViews addObject:iv];
            [iv release];
        }
    }
    return self;
}

- (void)dealloc
{
    [_imageViews release];
    [super dealloc];
}

- (void)handleTouchAtLocation:(CGPoint)touchLocation {

    for(int i = _imageViews.count - 1; i >= 0; i--) 
    {
        UIImageView *imageView = [_imageViews objectAtIndex:i];        

        //check if touch is inside star
        if (CGRectContainsPoint(imageView.frame, touchLocation))
        {
            CGPoint relativePoint = [self convertPoint:touchLocation toView:imageView];
            
            if(relativePoint.x > imageView.frame.size.width/2)
                _rating = i + 1; //touch is on the right side of star - star is full
            else
                _rating = i + 0.5f; //touch is on the left side of star - star is half empty
            
            [self updateRating];
            return;
        }
    }
    
    //touch is outside of star
    for(int i = _imageViews.count - 1; i >= 0; i--) 
    {
        UIImageView *imageView = [_imageViews objectAtIndex:i];        
        
        if (touchLocation.x >= imageView.frame.origin.x + imageView.frame.size.width)
        {
            _rating = i + 1;
            [self updateRating];
            return;
        }
    }
    
    //touch to the left from first star
    _rating = 0.5f;
    [self updateRating];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    [self handleTouchAtLocation:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if(self.delegate)
    {
        [self.delegate ratingBar:self 
                 didChangeRating:_rating];
    }
}

#pragma mark - Updating UI

- (void)clean
{
    for(NSInteger i=0; i<_imageViews.count; i++)
    {
        UIImageView *star = (UIImageView *)[_imageViews objectAtIndex:i];
        star.image = _offImage;
    }
}

- (void)updateRating
{
    [self clean];
    
    NSInteger i;
    
    //set every full star
    for(i=1; i<=MIN(_imageViews.count, _rating); i++)
    {
        UIImageView *star = (UIImageView *)[_imageViews objectAtIndex:i-1];
        star.image = _onImage;
    }
    
    if (i > _imageViews.count)
        return;
    
    //now add a half star if rating is appropriate
    if(_rating - i + 1 >= 0.5f)
    {
        UIImageView *star = (UIImageView *)[_imageViews objectAtIndex:i-1];
        star.image = _halfImage;
    }
}

@end
