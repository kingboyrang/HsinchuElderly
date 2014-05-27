#import <Foundation/Foundation.h>
//請求方式(ServiceHttpSoap1與ServiceHttpSoap12的區別在於請求頭不一樣)
typedef enum{
    ServiceHttpGet=0,
    ServiceHttpPost=1,
    ServiceHttpSoap1=2,
    ServiceHttpSoap12=3
}ServiceHttpWay;

@interface ServiceArgs : NSObject
@property(nonatomic,readonly) NSURLRequest *request;
@property(nonatomic,readonly) NSURL *webURL;
@property(nonatomic,readonly) NSString *hostName;
@property(nonatomic,readonly) NSString *defaultSoapMesage;
@property(nonatomic,readonly) NSString *contentType;
@property(nonatomic,readonly) NSString *httpMethod;//請求方法
@property(nonatomic,readonly) NSString *operationPath;

@property(nonatomic,assign)   ServiceHttpWay httpWay;//請求方式,預設为ServiceHttpSoap12請求
@property(nonatomic,assign)   NSTimeInterval timeOutSeconds;//請求超過時間,預設60秒
@property(nonatomic,assign)   NSStringEncoding defaultEncoding;//預設编辑
@property(nonatomic,copy)     NSString *serviceURL;//webservice訪問地址
@property(nonatomic,copy)     NSString *serviceNameSpace;//webservice命名空間
@property(nonatomic,copy)     NSString *methodName;//調用的方法名
@property(nonatomic,copy)     NSString *bodyMessage;//請求字串
@property(nonatomic,copy)     NSString *soapHeader;//有認證的請求頭設置
@property(nonatomic,retain)   NSDictionary *headers;//請求頭
@property(nonatomic,retain)   NSArray *soapParams;//方法參數設置

+(ServiceArgs*)serviceMethodName:(NSString*)methodName;
+(ServiceArgs*)serviceMethodName:(NSString*)methodName soapMessage:(NSString*)soapMsg;
//webservice訪問設置
+(void)setNameSapce:(NSString*)space;
+(void)setWebServiceURL:(NSString*)url;
-(NSURL*)requestURL;
@end