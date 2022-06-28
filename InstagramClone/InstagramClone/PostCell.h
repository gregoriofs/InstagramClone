//
//  PostCell.h
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/28/22.
//

#import <UIKit/UIKit.h>
#import <Parse/PFImageView.h>
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) Post* post;


@end

NS_ASSUME_NONNULL_END
