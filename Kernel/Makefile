KERNELDIR=/lib/modules/`uname -r`/build
#ARCH=i386
#KERNELDIR=/usr/src/kernels/`uname -r` -i686

MODULES = helloword.ko
obj-m += helloword.o

all:
	make -C $(KERNELDIR) M=$(PWD) modules
