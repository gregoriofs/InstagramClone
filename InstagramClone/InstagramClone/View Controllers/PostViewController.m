//
//  PostViewController.m
//  InstagramClone
//
//  Created by Gregorio Floretino Sanchez on 6/27/22.
//

#import "PostViewController.h"
#import "SceneDelegate.h"
#import "LogInViewController.h"
#import "HomeFeedViewController.h"
#import "Post.h"
#import "HomeFeedViewController.h"


@interface PostViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (void)selectingPictureforCamera;
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;
@property (strong, nonatomic) UIImagePickerController *imageVC;

@end

@implementation PostViewController

- (IBAction)didTapPostButton:(id)sender {
    
    [Post postUserImage: self.postImage.image withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Succesfully posted image");
            [self.delegate finishedPost];
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            NSLog(@"Error: Unable to post image");
        }

    }];
    
}


- (IBAction)didTapBackButton:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HomeFeedViewController *home = [storyboard instantiateViewControllerWithIdentifier:@"MainTabBarViewController"];
    
    myDelegate.window.rootViewController = home;
    
}

- (IBAction)didTapTakePhoto:(id)sender {
    [self selectingPictureforCamera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.imageVC = [UIImagePickerController new];
    self.imageVC.delegate = self;
    self.imageVC.allowsEditing = YES;
    
    self.postImage.layer.borderColor = UIColor.blackColor.CGColor;
    self.postImage.layer.borderWidth = 2;
    
    
}

-(void)selectingPictureforCamera{
    
    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        self.imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:self.imageVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    
    CGSize size = CGSizeMake(384.0, 241.0);
    
    self.postImage.image = [self resizeImage:editedImage withSize:size];
//    self.postImage.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
