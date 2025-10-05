#include <gpiod.h>
static struct gpiod_chip *chip=NULL;
static struct gpiod_line *led=NULL,*btn=NULL;
int gpio_init(int l,int b){
    chip=gpiod_chip_open_by_name("gpiochip0");
    if(!chip)return -1;
    if(l>0){led=gpiod_chip_get_line(chip,l);if(!led||gpiod_line_request_output(led,"led",0)<0)return -1;}
    if(b>0){btn=gpiod_chip_get_line(chip,b);if(!btn||gpiod_line_request_input_flags(btn,"btn",GPIOD_LINE_REQUEST_FLAG_BIAS_PULL_UP)<0)return -1;}
    return 0;
}
void gpio_write(int v){if(led)gpiod_line_set_value(led,v);}
int gpio_read(){return btn?gpiod_line_get_value(btn):-1;}
void gpio_cleanup(){if(led)gpiod_line_release(led);if(btn)gpiod_line_release(btn);if(chip)gpiod_chip_close(chip);}
