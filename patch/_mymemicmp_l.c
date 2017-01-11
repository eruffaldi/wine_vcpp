
extern int _memicmp(const void *buf1,  const void *buf2, int x);
int mymemicmp_l(const void *buf1,  const void *buf2, int x,void * p)
{
	return _memicmp(buf1,buf2,x);
}