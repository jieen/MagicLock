//
//  ViewController.swift
//  MagicLock
//
//  Created by test on 14/11/25.
//  Copyright (c) 2014年 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var vBootomHeight = 50.0
    var bgxoffset = 8.0
    var bgyoffset = 20.0
    var bgheadoffset = 100.0
    var bgbootomoffset = 100.0
    var vMainImg:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //获取屏幕尺寸
        var screen = getScreenSize()
        var width = screen.width
        var height = screen.height
        //加载默认图片
        testLoadPic(width,height: height)
        //添加菜单栏
        var toolBar = UIToolbar()
        toolBar.frame = CGRect(x:0,y:height - CGFloat(vBootomHeight),width:width,height:CGFloat(vBootomHeight))
        toolBar.sizeToFit()
//        toolBar.setItems(toolbarItems, animated: true)
        toolBar.barStyle = UIBarStyle.Black //Default
//        toolBar.barTintColor = UIColor.whiteColor()
        let toolbarbuttonItems = [
            addButtonItem,
            flexibleSpaceBarButtonItem,
            refreshButtonItem,
            flexibleSpaceBarButtonItem,
            saveButtonItem
        ]
        toolBar.setItems(toolbarbuttonItems, animated: true)
        view.addSubview(toolBar)
    }
    
    var refreshButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("barButtonItemAction:"))
    }
    var addButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: Selector("selectImageButtonItemAction:"))
    }
    
    var saveButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: Selector("saveButtonItemAction:"))
    }
    
    var flexibleSpaceBarButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: Selector("barButtonItemAction:"))
    }
    
    var actionButtonItem: UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: Selector("barButtonItemAction:"))
    }
    
    //选择图片
    func selectImageButtonItemAction(barBtnItem: UIBarButtonItem){
        println("selectImageButtonItemAction! \(barBtnItem)")
        let imgpicker = UIImagePickerController()
        imgpicker.delegate = self
        imgpicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imgpicker, animated: true, completion: nil)
    }
    //图片选中处理
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
        println(info)
        picker.dismissViewControllerAnimated(true, completion: nil)
        //设置图标
        vMainImg.image=info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    //图片选择取消处理
    func imagePickerControllerDidCancel(picker: UIImagePickerController!)
    {
        println("picker cancel.")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //保存按钮处理事件
    func saveButtonItemAction(barBtnItem: UIBarButtonItem){
        println("save button clicked")
    }
    //toolBar按键处理
    func barButtonItemAction(barButtonItem: UIBarButtonItem) {
        println("A bar button item was clicked! \(barButtonItem)")
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func testLoadPic(width:CGFloat,height:CGFloat)
    {
        loadPicByLocalData(width,height: height)
        loadPicByLocalData1(width,height: height)
        loadPicByLocalData2(width,height: height)
        composePic()
//        loadPicByNetData()
//        loadPicByLocalResource()
    }
    
    func loadPicByNetData(){
        //以网络数据方式加载
        var nsd = NSData(contentsOfURL:NSURL(fileURLWithPath: "http://e.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=0eafda37718da9775a228e79d138937c/b3b7d0a20cf431ad8fd05a3d4936acaf2edd98b7.jpg")!)
        var img = UIImage(data: nsd!)
        var vImg = UIImageView(image: img)                      //初始化图片View
        vImg.frame.origin = CGPoint(x:0,y:20)                   //指定图片显示的位置
        //        vImg.frame = CGRect(x:0,y:20,width:120,height:120)    //指定图片的位置以及显示的大小
        vImg.layer.cornerRadius = 8;
        vImg.layer.masksToBounds = true;
        self.view.addSubview(vImg)
    }
    
    func loadPicByLocalResource(){
        var img = UIImage(named:"04")                      //以本地资源加载 初始化图片
        var vImg = UIImageView(image: img)                      //初始化图片View
        vImg.frame.origin = CGPoint(x:0,y:20)                   //指定图片显示的位置
        //        vImg.frame = CGRect(x:0,y:20,width:120,height:120)    //指定图片的位置以及显示的大小
        vImg.layer.cornerRadius = 8;
        vImg.layer.masksToBounds = true;
        self.view.addSubview(vImg)
    }
    
    func loadPicByLocalData(width:CGFloat,height:CGFloat)
    {
        var imageData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("04", withExtension: "jpg")!)
        let img = UIImage(data:imageData!,scale:1.0)
        var vImg = UIImageView(image: img)
        vMainImg = vImg
//        vImg.frame.origin = CGPoint(x:0,y:20)
        
        var vImgx:CGFloat = 8.0
        var vImgy:CGFloat = 20.0
        
        var vImgwidth = width - CGFloat(vImgx * 2)
        println(vImgwidth)
        var vImgheight = height - CGFloat(vImgy) - CGFloat(vBootomHeight)
        
         println("x: \(vImgx),y:\(vImgy),wid:\(vImgwidth),hei:\(vImgheight)")
        
        vImg.frame = CGRect(x: vImgx, y: vImgy, width: vImgwidth, height: vImgheight)
        vImg.layer.cornerRadius = 8
        vImg.layer.masksToBounds = true;
        vImg.contentMode = UIViewContentMode.ScaleAspectFill//Center//ScaleToFill//ScaleAspectFit
        view.addSubview(vImg)
    }
    
    
    func loadPicByLocalData1(width:CGFloat,height:CGFloat)
    {
        var imageData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("04", withExtension: "jpg")!)
        let img = UIImage(data:imageData!,scale:1.0)
        var vImg = UIImageView(image: img)
        //        vImg.frame.origin = CGPoint(x:0,y:20)
        
        var vImgx:CGFloat = 8.0
        var vImgy:CGFloat = 20.0
        
        var vImgwidth = width - CGFloat(vImgx * 2)
        println(vImgwidth)
        var vImgheight = (height - CGFloat(vImgy) - CGFloat(vBootomHeight))/6
        
        println("x: \(vImgx),y:\(vImgy),wid:\(vImgwidth),hei:\(vImgheight)")
        
        vImg.frame = CGRect(x: vImgx, y: vImgy, width: vImgwidth, height: vImgheight)
        vImg.layer.cornerRadius = 8
        vImg.layer.masksToBounds = true;
        vImg.contentMode = UIViewContentMode.ScaleAspectFill//Center//ScaleToFill//ScaleAspectFit
        view.addSubview(vImg)
    }
    
    func loadPicByLocalData2(width:CGFloat,height:CGFloat)
    {
        var imageData = NSData(contentsOfURL: NSBundle.mainBundle().URLForResource("04", withExtension: "jpg")!)
        let img = UIImage(data:imageData!,scale:1.0)
        var vImg = UIImageView(image: img)
        //        vImg.frame.origin = CGPoint(x:0,y:20)
        
        var vImgx:CGFloat = CGFloat(bgxoffset)
        var vImgy:CGFloat = height - CGFloat(bgbootomoffset) - CGFloat(vBootomHeight)
        
        var vImgwidth = width - CGFloat(vImgx * 2)
        println("bg2 : \(vImgy)")
        var vImgheight = CGFloat(bgbootomoffset)
        
        println("x: \(vImgx),y:\(vImgy),wid:\(vImgwidth),hei:\(vImgheight)")
        
        vImg.frame = CGRect(x: vImgx, y: vImgy, width: vImgwidth, height: vImgheight)
        vImg.layer.cornerRadius = 8
        vImg.layer.masksToBounds = true;
        vImg.contentMode = UIViewContentMode.ScaleAspectFill//Center//ScaleToFill//ScaleAspectFit
        view.addSubview(vImg)
    }
    
    
    
    
    
    func composePic(){
        var newImg = UIImage()
//        newImg.drawAtPoint(CGPoint(x: 0,y: 0),.kCGBlendModeNormal,0.5)
    }
    
    func getScreenSize()->CGRect
    {
        println(UIScreen.mainScreen().bounds)
        println(UIScreen.mainScreen().bounds.height)
        return UIScreen.mainScreen().bounds
    }
    
    
}

