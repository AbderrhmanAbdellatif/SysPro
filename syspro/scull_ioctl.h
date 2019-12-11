#ifndef __SCULL_H
#define __SCULL_H

#include <linux/ioctl.h> /* needed for the _IOW etc stuff used later */

#define MEMO_IOC_MAGIC  'k'
#define MEMO_CLEAR    _IO(MEMO_IOC_MAGIC, 0)
#define MEMO_SET_MODE  _IOW(MEMO_IOC_MAGIC,  1, int)
#define MEMO_GET_MODE _IOR(MEMO_IOC_MAGIC,  2, int)
#define SCULL_IOC_MAXNR 2

#endif
