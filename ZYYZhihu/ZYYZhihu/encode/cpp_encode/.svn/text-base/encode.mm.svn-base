#include <stdio.h>
#include <string.h>
#include "md5.h"
#include "encode.h"
#include "NSBase64.h"

#define STATIC_MIXBITS_INDEX	111

//public static int EBT_FOR_SIGN = 1;
const unsigned char S_PRIVATE_KEY1[] = "cc16be4b:346c51d";
const unsigned char eto32_table1[]="AB56DE3C8L2WF4UVM7JRSGPQYZTXK9HN";

//public static int EBT_FOR_USERPASSWORD = 2;
const unsigned char S_PRIVATE_KEY2[] = "@kK1818$";
const unsigned char eto32_table2[]="2WF4JZ7XKTC8LSGHUDEPQYVM9R63NAB5";

//PAY ATTENTION: my_bits_disp only is allowed to encode a string whose length is less than 22 charactors
int my_bits_disp(unsigned char * pSrcDestBits, unsigned char nSrcBitsLen,
				  unsigned char * pDispBits, unsigned char nDispBitsLen,
				  unsigned short nIndex)
{
	unsigned int i;
	if(!pSrcDestBits || !pDispBits || (nSrcBitsLen+nDispBitsLen)<2 ||
		(nSrcBitsLen+nDispBitsLen)>255)
		return -1;

	unsigned char* pTemp=new unsigned char[nSrcBitsLen+nDispBitsLen];
	if(!pTemp)
		return -1;
	for(i=0; i<(unsigned int)nSrcBitsLen+nDispBitsLen; i++)
	{
		pTemp[i]=(unsigned char)i;
	}

	unsigned int n=(nSrcBitsLen-1)/8+1;
	//change pSrcBits
	for(i=0; i<n; i+=2)
	{
		*(pSrcDestBits+i)^=(unsigned char)nIndex;
	}

	//dispatch pDispBits into pSrcBis
	//using nIndex+(nIndex+(13,21,34,55,...))%nSrcBitsLen select insert point.
	unsigned int a=13, b=21;
	unsigned int s=nDispBitsLen;
	unsigned char v;
	while(nDispBitsLen)
	{
		//use a
		n=(nIndex+(nIndex+a)%nSrcBitsLen)%nSrcBitsLen;
		for(i=nSrcBitsLen; i>n; i--)
		{
			pTemp[i]=pTemp[i-1];
		}
		pTemp[n]=nSrcBitsLen;
		b=a+b;
		a=b-a;
		nSrcBitsLen++;
		nDispBitsLen--;
	}
	nDispBitsLen=s;
	nSrcBitsLen=nSrcBitsLen-nDispBitsLen;
	unsigned char * pFrom;
	for(i=0; i<(unsigned int)nSrcBitsLen+nDispBitsLen; i++)
	{
		if(pTemp[i]>=nSrcBitsLen)
		{
			pFrom=pDispBits;
			pTemp[i]-=nSrcBitsLen;
		}
		else
		{
			pFrom=pSrcDestBits;
		}
		v=*(pFrom+pTemp[i]/8);
		v>>=(7-pTemp[i]%8);
		pTemp[i]=v;
	}
	pFrom=pSrcDestBits;
	v=0;
	for(i=0; i<(unsigned int)nSrcBitsLen+nDispBitsLen; i++)
	{
		v|=(pTemp[i]&1)<<(7-i%8);
		if(i%8==7)
		{
			*(pFrom++)=v;
			v=0;
		}
	}
	if(i%8!=0)
		*(pFrom++)=v;
	delete [] pTemp;
	return nSrcBitsLen+nDispBitsLen;
}

int my_bits_disp_reverse(unsigned char * pSrcDestBits, unsigned char nSrcBitsLen,
				 unsigned char * pDispBits, unsigned char nDispBitsLen,
				 unsigned short nIndex)
{
	unsigned int i;
	unsigned int j;
	if(!pSrcDestBits || !pDispBits || (nSrcBitsLen+nDispBitsLen)<2 ||
		(nSrcBitsLen+nDispBitsLen)>255)
		return -1;
	
	unsigned char* pTemp=new unsigned char[nSrcBitsLen+nDispBitsLen];
	if(!pTemp)
		return -1;
	for(i=0; i<(unsigned int)nSrcBitsLen+nDispBitsLen; i++)
	{
		pTemp[i]=(unsigned char)i;
	}
	
	unsigned int n;
	//dispatch pDispBits into pSrcBis
	//using nIndex+(nIndex+(13,21,34,55,...))%nSrcBitsLen select insert point.
	unsigned int a=13, b=21;
	unsigned int s=nDispBitsLen;
	unsigned char v;
	while(nDispBitsLen)
	{
		//use a
		n=(nIndex+(nIndex+a)%nSrcBitsLen)%nSrcBitsLen;
		for(i=nSrcBitsLen; i>n; i--)
		{
			pTemp[i]=pTemp[i-1];
		}
		pTemp[n]=nSrcBitsLen;
		b=a+b;
		a=b-a;
		nSrcBitsLen++;
		nDispBitsLen--;
	}
	nDispBitsLen=s;
	nSrcBitsLen=nSrcBitsLen-nDispBitsLen;
	
	v=0;
	a=0;
	for(j=nSrcBitsLen; j<(unsigned int)nDispBitsLen+nSrcBitsLen; j++)
	{
		for(i=0; i<(unsigned int)nSrcBitsLen+nDispBitsLen; i++)
		{
			if(j==pTemp[i])
			{
				v|=((pSrcDestBits[i/8]>>(7-i%8))&1)<<(7-a);
				if(a%8==7)
				{
					*(pDispBits++)=v;
					v=0;
					a=0;
				}
				else
					a++;
				break;
			}
		}
	}
	if(a!=0)
		*(pDispBits++)=v;

	v=0;
	j=0;
	for(i=0; i<(unsigned int)nSrcBitsLen+nDispBitsLen; i++)
	{
		if(pTemp[i]<nSrcBitsLen)
		{
			v|=((pSrcDestBits[i/8]>>(7-i%8))&1)<<(7-j%8);
			if(j%8==7)
			{
				*(pSrcDestBits+j/8)=v;
				v=0;
			}
			j++;
		}
	}
	if(j%8!=0)
		*(pSrcDestBits+j/8)=v;
	n=(nSrcBitsLen-1)/8+1;
	//change pSrcBits
	for(i=0; i<n; i+=2)
	{
		*(pSrcDestBits+i)^=(unsigned char)nIndex;
	}	
	delete [] pTemp;
	return nSrcBitsLen+nDispBitsLen;
}

void encode(unsigned char * in, unsigned int ilen, 
			unsigned char * out, unsigned int olen, char* eto32_table)
{
	//_ASSERT(in && out);
	int s=0;
	unsigned int j=0;
	unsigned char buf[2]={0};
	for(unsigned int i=0; i<ilen; i++)
	{
		buf[0]=*(in+i);
		buf[1]=i+1<ilen?*(in+i+1):0;
		buf[0]<<=s;buf[0]>>=s;	//clear before s 
		if(s>=3)
		{
			buf[0]=(buf[0]<<(s-3))|(buf[1]>>(11-s));
			*(out+j++)=eto32_table[buf[0]];
			s=s-3;
		}
		else
		{
			*(out+j++)=eto32_table[buf[0]>>(8-s-5)];
			s+=5;
			i--;	//still consume this byte
			//_ASSERT(s<8);
		}
		if(j>=olen)
			break;
	}
}
bool decode(unsigned char * in , unsigned int ilen, unsigned int sb, 
			unsigned char * out, unsigned int olen, char* eto32_table)
{
	//sb --> 0-4
	memset(out, 0, olen);
	int left=0;//left --> 0-7
	unsigned char m;
	
	if(sb>=5)
		return false;
	unsigned int i=0;
	unsigned int j=0;
	while(i<ilen)
	{		
		for(m=0; m<32; m++) 
		{	
			if(in[i]==eto32_table[m]) 
				break;
		}
		if(m==32)
			return false;
		while(sb<5)
		{
			if(m&((unsigned char)1<<(4-sb)))
				out[j]|=((unsigned char)1<<(7-left));
			left++;
			if(left==8)
			{
				left=0;
				j++;
				if(j>=olen)
					return true;//false
			}
			sb++;
		}
		i++;
		sb=0;
	}
	return true;
}


int encodeUserNameAndPassword(const char* namepassword, int len, 
							  char** ppEncoded, int* pEncodedLen)
{
	if(namepassword == NULL || len < 8 || ppEncoded == NULL)
		return -1;

	//12 chars for one section
	int secs = (len/12 + (len%12 == 0? 0:1));
	*ppEncoded = new char[secs * 20];//every sec needs 32 bytes
	memset(*ppEncoded, 0, secs*20);
	*pEncodedLen = 0;

	unsigned short mixer = STATIC_MIXBITS_INDEX;
	char* p = *ppEncoded;
	int lenSec = 12;
	for(int i=0; i<secs; i++){
		if(i+1 == secs)
			lenSec = len - i*12;
		memcpy(p+i*20, namepassword+i*12, lenSec);
		int a = my_bits_disp((unsigned char*)(p+i*20), lenSec*8, (unsigned char*)S_PRIVATE_KEY2, 8*8, mixer);
		*pEncodedLen += a/8;
		mixer = (unsigned char)(*(p+(i+1)*20-1));
	}

	return 0;
}

@implementation HttpRequestEncoder

+ (NSString*) encodeParam:(NSString*)param
{
    const char* pEncode = [param UTF8String];
    int lenEncode = strlen(pEncode);
    
    char* pEncoded = NULL;
    int lenEncoded = 0;
    int iRet = encodeUserNameAndPassword(pEncode, lenEncode, &pEncoded, &lenEncoded);
    if(iRet == -1 || pEncoded == NULL)
        return nil;
    
    int len = lenEncoded*8/5 + ((lenEncoded*8)%5 != 0?1:0);
    char* output = new char[len + 1];
    encode((unsigned char*)pEncoded, lenEncoded, (unsigned char*)output, len, (char*)eto32_table2);//将up值按照我们的方式encode成字符串编码
    output[len] = 0;
    
    NSString* strEncoded = [NSString stringWithUTF8String:output];
    delete [] output;
    delete [] pEncoded;
    
    return strEncoded;
}

+ (NSString*) encodeUserName:(NSString*)name andPassword:(NSString*)pwd
{
    NSString* temp = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                              (CFStringRef)name,
                                                                              NULL,
                                                                              NULL,
                                                                              kCFStringEncodingUTF8));
    NSString* strEncode = [NSString stringWithFormat:@"u=%@&p=%@", temp, pwd];
    return [HttpRequestEncoder encodeParam:strEncode];
}

+ (NSString*) encodeUuid:(NSString*)uuid
{
    NSString* strEncode = [NSString stringWithFormat:@"uuid=%@", uuid];
    return [HttpRequestEncoder encodeParam:strEncode];
}

+ (NSString*) encodeUnionid:(NSString*)unionid
{
    NSString* strEncode = [NSString stringWithFormat:@"unionid=%@", unionid];
    return [HttpRequestEncoder encodeParam:strEncode];
}

+ (NSString*) encodeNewPassword:(NSString*)newpwd
{
    NSString* strEncode = [NSString stringWithFormat:@"dp=%@", newpwd];
    return [HttpRequestEncoder encodeParam:strEncode];
}

+ (NSString*) encodeParamWithKey:(NSString*)param
{
    const char* temp = [param UTF8String];
    char* pEncode = new char[strlen(temp) + 16 + 1];//字符串中加入S_PRIVATE_KEY1 => 16 bytes
    strcpy(pEncode, temp);
    strcat(pEncode, (const char*)S_PRIVATE_KEY1);
    pEncode[strlen(temp) + 16] = 0;
    
    unsigned char* p = MD5((const unsigned char *)pEncode, strlen(pEncode), NULL);//做MD5计算
    
    unsigned char encoded[27] = {0};
    encode(p, MD5_DIGEST_LENGTH, encoded, 26, (char*)eto32_table1);//将MD5值按照我们的方式encode成字符串
    
    NSString* strEncoded = [NSString stringWithUTF8String:(const char*)encoded];
    delete [] pEncode;
    
    return strEncoded;
}

+ (NSDictionary*) decodeUDPD:(NSString*)udpd
{
    NSData *data = [udpd base64DecodedData];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSMutableString *output = [[NSMutableString alloc] init];
    NSString *decodeStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    int idx = 0;
    while(decodeStr.length > 0)
    {
        NSString *s = [decodeStr substringWithRange:NSMakeRange(0, 3)];
        int i = [s intValue];
        char c[2] = {0};
        if (idx%2 == 0)
        {
            c[0] = (char)(i - 'u');
        }
        else
        {
            c[0] = (char)(i - 'p');
        }
        [output appendString:[NSString stringWithUTF8String:c]];
        decodeStr = [decodeStr substringFromIndex:3];
        idx++;
    }
    NSCharacterSet *characterSet1 = [NSCharacterSet characterSetWithCharactersInString:@":"];
    NSArray *array1 = [output componentsSeparatedByCharactersInSet:characterSet1];
    if (array1.count == 2 )
    {
        [dic setObject:[array1 objectAtIndex:0] forKey:UP_USERID];
        [dic setObject:[array1 objectAtIndex:1] forKey:UP_PASSWORD];
    }
    return dic;
}

@end
/*
int _tmain(int argc, _TCHAR* argv[])
{
	const char namepassword[] = "u=terryzlf1&p=1234567";//将用户名密码按照这种格式拼接。用户名请先urlencode一下，使用utf-8编码
	int len = sizeof(namepassword) -1;

	char* pEncoded = NULL;
	int lenEncoded = 0;
	int iRet = encodeUserNameAndPassword(namepassword, len, &pEncoded, &lenEncoded);//调用encodeUserNameAndPassword加密成up参数，注意释放pEncoded返回值
	if(iRet == -1 || pEncoded == NULL)
		printf("Error encode user name and password.\n");
	else 
	{	
		printf("User name and password is encoded (length:%d)\n", lenEncoded);

		int strLen = lenEncoded*8/5 + ((lenEncoded*8)%5 != 0?1:0);
		unsigned char* encodedUP = new unsigned char[strLen + 1];
		encode((unsigned char*)pEncoded, lenEncoded, encodedUP, strLen, (char*)eto32_table2);//将up值按照我们的方式encode成字符串编码
		encodedUP[strLen] = 0;
		printf("username and password is encoded into : %s\n", encodedUP);

		//we have make user name and password into one value - up
		//now test to sign 

		const char* testStr2 = "FuncTag:40000001platform:2up:";//参数先按照字母大小写不相关排序，从小到大。 然后拼接所有参数值，注意这里参数之间用“:”分割，参数间连续拼接中不加“:”
		char* temp = new char[strlen(testStr2) + strLen + 16 + 1];// 测试字符串中加入上面计算出来的up参数，最后的字符串中加入S_PRIVATE_KEY1 => 16 bytes
		strcpy(temp, testStr2);
		strcat(temp, (const char*)encodedUP);
		strcat(temp, (const char*)S_PRIVATE_KEY1);
		
		unsigned char* p = MD5((const unsigned char *)temp, strlen(temp), NULL);//做MD5计算

		unsigned char encoded[27] = {0};
		encode(p, MD5_DIGEST_LENGTH, encoded, 26, (char*)eto32_table1);//将MD5值按照我们的方式encode成字符串
		printf("MD5 and encoded string: %s \n", encoded);

		delete [] temp;
		delete [] encodedUP;
		delete [] pEncoded;//don't forget to release the alloced buffer
	}

	//最后调用接口方式为
	//http://10.0.1.195:8080/meShow/entrance?parameter={"FuncTag":40000001,"platform":2,"up":"FKRUYNA77NFC7EYE9YZLSS27E8L4FBFGQM5KRBK35WH2CZBQ7RCBJUAJ4V2U","sv":"YABFVEFXWMZ4F5HHV7CVSSYNMS"}
	return 0;
}*/
