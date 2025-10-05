#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/spi/spidev.h>

#define AD911X_READ_OPERATION 0x80
#define AD911X_AUXDAC_ADDR(chan) (0x09+(chan*2))
#define AD911X_AUXDAC_ENABLE 0x80
#define AD911X_AUXDAC_TOP1V 0x0
#define AD911X_AUXDAC_TOP2V 0x2
#define AD911X_AUXDAC_RANGE2V 0x0
#define AD911X_GAINCTL_ADDR(chan) (0x03+(chan*3))
#define AD911X_INTERNAL_RSET_ENABLE 0x80
#define AD911X_CLKMODE_ADDR 0x14
#define AD911X_CLKMODE_ENABLE 0x04


#define NUM_COMMANDS 4

int main(int argc, char *argv[])
{
  int i, fd, value;

  uint8_t data[NUM_COMMANDS * 2] =
  {
    0x00, 0x20,		//RESET
    (AD911X_GAINCTL_ADDR(0) + 1), (AD911X_INTERNAL_RSET_ENABLE | 0x20),
    (AD911X_GAINCTL_ADDR(1) + 1), (AD911X_INTERNAL_RSET_ENABLE | 0x20),
    (AD911X_CLKMODE_ADDR), (AD911X_CLKMODE_ENABLE | 0x00)	//DCLKIO = CLKIN
  };

  fd = open("/dev/spidev0.1", O_RDWR);

  value = SPI_MODE_0;
  ioctl(fd, SPI_IOC_WR_MODE, &value);

  value = 8;
  ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &value);

  value = 1000000;
  ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &value);

  for (i=0;i<NUM_COMMANDS;++i){
	printf("%02x %02x\n",data[i*2],data[i*2+1]);
  	write(fd, &data[i*2], 2);
       	if(i==0)
	    sleep(1);
  }

  close(fd);

  return EXIT_SUCCESS;
}
