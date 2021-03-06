//
//  UIImage+ACY_ImageOrientation.m
//  Pods
//
//  Created by Arthur Liu on 2017/05/26.
//
//

#import "UIImage+ACY_ImageOrientation.h"

@implementation UIImage (ACY_ImageOrientation)

- (CGSize)acy_displaySize {
    
    CGSize size = self.size;
    
    return [self acy_displayPortrait] ?
    CGSizeMake(size.height, size.width) :
    size;
    
}


/**
 Get the data from real test. But I found that is not compatiable with the image property imageOrientatin. Still can not understand.

 @return <#return value description#>
 */
- (BOOL)acy_displayPortrait {
    
    
    switch (self.imageOrientation) {
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored: return YES;
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored: return NO;
    }
}

- (CGAffineTransform)acy_transformByImageOrientation {
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    if (self.imageOrientation == UIImageOrientationUp) {
        return transform;
    }
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight: break;
    }
    
    return transform;
    
}



@end
