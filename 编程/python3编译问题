
在python3中
pip install出现
Retrying (Retry(total=4, connect=None, read=None, redirect=None, status=None)) after connection broken by 'SSLError("Can't connect to HTTPS URL because the SSL module is not available.")': /simple/django/

说明python编译过程中没有编译ssl模块 

需要在vi Modules/Setup.dist修改
将
#_ssl _ssl.c \
#-DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
#-L$(SSL)/lib -lssl -lcrypto
    ||   修改为
    \/
_ssl _ssl.c \
-DUSE_SSL -I$(SSL)/include -I$(SSL)/include/openssl \
-L$(SSL)/lib -lssl -lcrypto

在进行./configure, make , make install