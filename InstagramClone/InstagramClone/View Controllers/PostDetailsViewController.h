//
//  PostDetailsViewController.h
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/28/22.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Parse.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN



@interface PostDetailsViewController : UIViewController
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;


@end

NS_ASSUME_NONNULL_END
