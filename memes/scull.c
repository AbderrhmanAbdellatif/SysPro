#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>


#include <linux/kernel.h> /* printk() */
#include <linux/slab.h>   /* kmalloc() */
#include <linux/fs.h>     /* everything... */
#include <linux/errno.h>  /* error codes */
#include <linux/types.h>  /* size_t */
#include <linux/proc_fs.h>
#include <linux/fcntl.h> /* O_ACCMODE */
#include <linux/seq_file.h>
#include <linux/cdev.h>

#include <asm/switch_to.h> /* cli(), *_flags */
#include <asm/uaccess.h>   /* copy_*_user */

#include "scull_ioctl.h"

#define SCULL_MAJOR 0
#define SCULL_NR_DEVS 4
int mod = 2;
int scull_major = SCULL_MAJOR;
int scull_minor = 0;
int scull_nr_devs = SCULL_NR_DEVS;

module_param(mod, int, S_IRUGO);

module_param(scull_major, int, S_IRUGO);
module_param(scull_minor, int, S_IRUGO);
module_param(scull_nr_devs, int, S_IRUGO);

MODULE_AUTHOR("Alessandro Rubini, Jonathan Corbet");
MODULE_LICENSE("Dual BSD/GPL");

struct Node
{
    char date; //[20];
    int measurement;
    struct Node *next;
};

struct memo
{
    //TODO MODE
    struct Node *data;
    struct semaphore sem;
    struct cdev cdev;
};

struct memo *memo_devices;

/*TODO: int scull_trim(struct scull_dev *dev)
{
    int i;

    if (dev->data) {
        struct Node currentNode = dev->data; 
        //for (i = 0; i < dev->qset; i++){
        while(currentNode->next){
                kfree(->);
        }
        kfree(dev->data);
    }
    dev->data = NULL;
    dev->size = 0;
    return 0;
}*/

int scull_open(struct inode *inode, struct file *filp)
{
    struct memo *dev;
                    printk(KERN_WARNING "Memo acildi mutlu ol :P.");

    dev = container_of(inode->i_cdev, struct memo, cdev);
    filp->private_data = dev;

    /* trim the device if open was write-only */
    if ((filp->f_flags & O_ACCMODE) == O_WRONLY)
    {
        if (down_interruptible(&dev->sem))
            return -ERESTARTSYS;
        // scull_trim(dev);
        up(&dev->sem);
    }
    return 0;
}

int scull_release(struct inode *inode, struct file *filp)
{
    return 0;
}

ssize_t scull_read(struct file *filp, char __user *buf, size_t count,
                   loff_t *f_pos)
{
    struct memo *dev = filp->private_data;
    ssize_t retval = 0;
                    printk(KERN_WARNING "Memo geldi current data yok girdi.");

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;

    if (dev->data == NULL)
        goto out;

    /* read only up to the end of this quantum */
    struct Node *currentNode;
    currentNode = dev->data;
    while (currentNode->next)
    {
        // TODO: node or data, should change to data... and date. (data + measure + /n) concat
        if (raw_copy_to_user(buf, currentNode, sizeof(currentNode)))
        {
            retval = -EFAULT;
            goto out;
        }
        buf = buf + sizeof(currentNode);
        currentNode = currentNode->next;
    }
      printk(KERN_WARNING "Memo geldi current data yok girdi. %s",buf);
              
    retval = count;

out:
    up(&dev->sem);
    return retval;
}

ssize_t scull_write(struct file *filp, const char __user *buf, size_t count,
                    loff_t *f_pos)
{


    struct memo *dev = filp->private_data;
    ssize_t retval = -ENOMEM;
                    printk(KERN_WARNING "Memo write data geldi, seyden once.");

    if (down_interruptible(&dev->sem))
        return -ERESTARTSYS;

    struct Node *currentNode;
    currentNode= dev->data;    //TODO alternative
                printk(KERN_WARNING "Memo write data from buffer = %s",buf);

    if (!currentNode)
    {
                    printk(KERN_WARNING "Memo write current data yok girdi.");

        currentNode =(struct Node *)kmalloc(sizeof(struct Node), GFP_KERNEL);
        //currentNode->measurement = kmalloc(sizeof(int) * 5, GFP_KERNEL);
        // currentNode->date = kmalloc(sizeof(char) * 10, GFP_KERNEL);
        
        if (!currentNode)
            goto out;
        //memset(dev->data, 0, qset * sizeof(char *));
    }
    else
    {
                    printk(KERN_WARNING "Memo write current data var girdi.");

       
        while (currentNode->next)
        {
            currentNode = currentNode->next;
        }
        currentNode->next = (struct Node *)kmalloc(sizeof(struct Node), GFP_KERNEL);
        currentNode = currentNode->next; // TODO alternative - currentNode next mesaruemnt 
        // currentNode->measurement = (int)kmalloc(sizeof(int) * 5, GFP_KERNEL);
        // currentNode->date = (char)kmalloc(sizeof(char) * 20, GFP_KERNEL);
        
        if (!currentNode)
            goto out;
    }
    //if (!dev->data[s_pos])
    //{
    //}

    if (raw_copy_from_user( currentNode->measurement, buf, sizeof(struct Node)))
    {
        retval = -EFAULT;
        goto out;
    }
    /* 
    TODO:
     time_t t = time(NULL);
      struct tm tm = *localtime(&t);
      printf("now: %d-%d-%d %d:%d:%d\n", tm.tm_year + 1900, tm.tm_mon + 1,tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec);
  time_to_tm f  
*/
      currentNode->date = '\n';//"1453/06/23 10:00\n";//TODO alternative 

    retval = count;

out:
    up(&dev->sem);
    return retval;
}

long scull_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
{

    int err = 0;
    int retval = 0;

    /*
	 * extract the type and number bitfields, and don't decode
	 * wrong cmds: return ENOTTY (inappropriate ioctl) before access_ok()
	 */
    if (_IOC_TYPE(cmd) != SCULL_IOC_MAGIC)
        return -ENOTTY;
    if (_IOC_NR(cmd) > SCULL_IOC_MAXNR)
        return -ENOTTY;

    /*
	 * the direction is a bitmask, and VERIFY_WRITE catches R/W
	 * transfers. `Type' is user-oriented, while
	 * access_ok is kernel-oriented, so the concept of "read" and
	 * "write" is reversed
	 */
    if (_IOC_DIR(cmd) & _IOC_READ)
        err = !access_ok(VERIFY_WRITE, (void __user *)arg, _IOC_SIZE(cmd));
    else if (_IOC_DIR(cmd) & _IOC_WRITE)
        err = !access_ok(VERIFY_READ, (void __user *)arg, _IOC_SIZE(cmd));
    if (err)
        return -EFAULT;

    switch (cmd)
    {
    case MEMO_CLEAR:
            printk(KERN_WARNING "Memo clear Major. %d\n Minor %d\n", scull_major,scull_minor);

       // scull_trim(filp->private_data);
        break;

    case MEMO_SET_MODE: /* Set: arg points to the value */
        if (!capable(CAP_SYS_ADMIN))
            return -EPERM;
        printk(KERN_WARNING "Memo set mode Major. %d\n Minor %d\n", scull_major,scull_minor);
        retval = __get_user(mod, (int __user *)arg);
        break;
   case MEMO_GET_MODE: /* Get: arg is pointer to result */
        printk(KERN_WARNING "Memo get mode Major. %d\n Minor %d\n", scull_major,scull_minor);
        retval = __put_user(mod, (int __user *)arg);
        break;
      default: /* redundant, as cmd was checked against MAXNR */
        return -ENOTTY;
    }
    return retval;
}

// loff_t scull_llseek(struct file *filp, loff_t off, int whence)
// {
//     struct scull_dev *dev = filp->private_data;
//     loff_t newpos;

//     switch (whence)
//     {
//     case 0: /* SEEK_SET */
//         newpos = off;
//         break;

//     case 1: /* SEEK_CUR */
//         newpos = filp->f_pos + off;
//         break;

//     case 2: /* SEEK_END */
//         newpos = dev->size + off;
//         break;

//     default: /* can't happen */
//         return -EINVAL;
//     }
//     if (newpos < 0)
//         return -EINVAL;
//     filp->f_pos = newpos;
//     return newpos;
// }

struct file_operations scull_fops = {
    .owner = THIS_MODULE,
    // .llseek = scull_llseek,
    .read = scull_read,
    .write = scull_write,
    .unlocked_ioctl = scull_ioctl,
    .open = scull_open,
    .release = scull_release,
};

void scull_cleanup_module(void)
{
    int i;
    dev_t devno = MKDEV(scull_major, scull_minor);

    if (memo_devices)
    {
        for (i = 0; i < scull_nr_devs; i++)
        {
            // scull_trim(scull_devices + i);
            cdev_del(&memo_devices[i].cdev);
        }
        kfree(memo_devices);
    }

    unregister_chrdev_region(devno, scull_nr_devs);
}

int scull_init_module(void)
{
                        printk(KERN_WARNING "Memo init oldu mutlu ol :P.");

    int result, i;
    int err;
    dev_t devno = 0;
    struct memo *dev;

    if (scull_major)
    {
        devno = MKDEV(scull_major, scull_minor);
        result = register_chrdev_region(devno, scull_nr_devs, "scull");
    }
    else
    {
        result = alloc_chrdev_region(&devno, scull_minor, scull_nr_devs,"scull");
        scull_major = MAJOR(devno);
    }
    if (result < 0)
    {
        printk(KERN_WARNING "scull: can't get major %d\n", scull_major);
        return result;
    }

    memo_devices = kmalloc(scull_nr_devs * sizeof(struct memo),
                            GFP_KERNEL);
    if (!memo_devices)
    {
        result = -ENOMEM;
        goto fail;
    }
    memset(memo_devices, 0, scull_nr_devs * sizeof(struct memo));

    /* Initialize each device. */
    for (i = 0; i < scull_nr_devs; i++)
    {
        dev = &memo_devices[i];
        sema_init(&dev->sem, 1);
        devno = MKDEV(scull_major, scull_minor + i);
        cdev_init(&dev->cdev, &scull_fops);
        dev->cdev.owner = THIS_MODULE;
        dev->cdev.ops = &scull_fops;
        err = cdev_add(&dev->cdev, devno, 1);
        if (err)
            printk(KERN_NOTICE "Error %d adding scull%d", err, i);
    }

    return 0; /* succeed */

fail:
    scull_cleanup_module();
    return result;
}

module_init(scull_init_module);
module_exit(scull_cleanup_module);
