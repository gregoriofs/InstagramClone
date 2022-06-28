//
//  PostViewController.h
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol finishedPostingDelegate <NSObject>

- (void)finishedPost;

@end

@interface PostViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UITextField *caption;
@property (weak, nonatomic) id<finishedPostingDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
