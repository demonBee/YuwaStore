//
//  OpenBusinessViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/30.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "OpenBusinessViewController.h"

@interface OpenBusinessViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UIImage*imageInfo;
@property(nonatomic,strong)UIImage*imageBelow;
@property(nonatomic,strong)NSString*saveLeftImageUrl;
@property(nonatomic,strong)NSString*saveRightImageUrl;
@property(nonatomic,assign)BOOL isTouchRightImage;  //点了左边图no  右边图yes
@property(nonatomic,assign)BOOL canSave;
@end

@implementation OpenBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"开通商务会员";
    self.view.backgroundColor=[UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchCommit:(id)sender {
  NSString*str= [self judgeCanSave];
    if (self.canSave==NO) {
        [JRToast showWithText:str];
        return;
    }
    
    //接口了
    [self commitDatas];
    
    
}


- (IBAction)touchOrderInfont:(UIButton*)sender {
    _isTouchRightImage=NO;
//    if (sender.selected) {
//        //删除照片
//        sender.selected=NO;
//        
//    }else{
//        //选中照片
//        sender.selected=YES;
//        
//    }
    
    [self TouchAddImage];

}

- (IBAction)touchOrderBlow:(UIButton*)sender {
       _isTouchRightImage=YES;
      [self TouchAddImage];
    
}






-(NSString*)judgeCanSave{
    self.canSave=YES;
    if (self.nameTextField.text.length<2) {
        self.canSave=NO;
        return @"名字输入错误";
    }else if (self.orderTextField.text.length!=11){
        self.canSave=NO;
        return @"身份证号错误";
    }else if (!self.imageInfo){
        self.canSave=NO;
        return @"请上传身份证正面";
        
    }else if (!self.imageBelow){
        self.canSave=NO;
        return @"请上传身份证反面";
    }
    
    
    
    return @"";
}



#pragma mark  --getDatas
-(void)commitDatas{
//上传图片
    NSArray*array=@[self.imageInfo,self.imageBelow];
    for (int i=0; i<array.count; i++) {
        NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_IMG_UP];
        NSData *imageData = UIImagePNGRepresentation(array[i]);
        
        HttpManager*manager=[[HttpManager alloc]init];
        [manager postUpdatePohotoWithUrl:urlStr withParams:nil withPhoto:imageData compliation:^(id data, NSError *error) {
            MyLog(@"%@",data);
            NSInteger number=[data[@"errorCode"] integerValue];
            if (number ==0) {
                if (i==0) {
                    self.saveLeftImageUrl=data[@"data"];
                }else{
                    self.saveRightImageUrl=data[@"data"];
                }
                
                
                
                //如果 都有值的话
                if (self.saveLeftImageUrl&&self.saveRightImageUrl) {
                    //这时候 就可以  吊 上传的接口了
                    
                    [self postDatas];

                }
                
                
                
            }else{
                [JRToast showWithText:data[@"errorMessage"]];
                
            }
            
            
        }];
        
        
        
    }
    
    
    
    
}


//上传的接口
-(void)postDatas{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,OPEN_BUSINESS];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"true_name":self.nameTextField.text,@"id_number":self.orderTextField.text,@"id_card":self.saveLeftImageUrl,@"id_card_back":self.saveRightImageUrl};
    
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSInteger number=[data[@"errorCode"] integerValue];
        if (number==0) {
            [JRToast showWithText:data[@"data"]];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
    }];
    
    
}


//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    
    if (self.isTouchRightImage) {
        //右边
        _imageBelow=newPhoto;
        [self.orderBlow setBackgroundImage:_imageBelow forState:UIControlStateNormal];
        
        
        
    }else{
        //左边的图
        _imageInfo=newPhoto;
        [self.orderInFont setBackgroundImage:_imageInfo forState:UIControlStateNormal];

    }
    
    //吊接口  照片
//    NSString *str = [ImageCache headImagePath:newPhoto];
//    
//    if (self.saveAllImage.count>=9) {
//        [JRToast showWithText:@"最多只能穿9张照片"];
//        return;
//    }
//    [self.saveAllImage addObject:newPhoto];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    
    //    NSDictionary*dict=@{@"header_img":str};
    //    [self changePersonInfoWithDic:dict];
    //    InfoPhotoTableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //    UIImageView*imageView=[cell viewWithTag:1];
    //    imageView.image=newPhoto;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)TouchAddImage{
    
    
    UIAlertController*alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing=YES;
        imagePicker.delegate=self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing=YES;
        imagePicker.delegate=self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
}

//touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
}


- (UIView*)findFirstResponderBeneathView:(UIView*)view
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
            return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result )
            return result;
    }
    return nil;
}



@end
