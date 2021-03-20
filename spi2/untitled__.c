#include <mega48.h>
 #include <lcd16x1.h>  
 #include <stdlib.h>  
 #include<delay.h>    
 // I2C Bus functions
#asm
   .equ __i2c_port=0x0B ;PORTD
   .equ __sda_bit=2
   .equ __scl_bit=3
#endasm
#include <i2c.h>

// DS1307 Real Time Clock functions
#include <ds1307.h>

// SPI functions
#include <spi.h>

// Declare your global variables here
              unsigned char data;
void main(void)
{
// Declare your local variables here
unsigned char AR[]="siddarth";    
unsigned char tm[]="TIME: ";
unsigned char dt[]="DATE: ";    
unsigned char h,m,s,i;  
unsigned char hr[3], min[3], sec[3]; 
unsigned char date, month, year;
unsigned char date1[3], month1[3], year1[3];


// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Input/Output Ports initialization
// Port B initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=In Func0=In 
// State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=T State0=T 
PORTB=0x00;
DDRB=0x3f;

// Port C initialization
// Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x01;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0xF0;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer 2 Stopped
// Mode: Normal top=FFh
// OC2A output: Disconnected
// OC2B output: Disconnected
ASSR=0x00;
TCCR2A=0x00;
TCCR2B=0x00;
TCNT2=0x00;
OCR2A=0x00;
OCR2B=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// Interrupt on any change on pins PCINT0-7: Off
// Interrupt on any change on pins PCINT8-14: Off
// Interrupt on any change on pins PCINT16-23: Off
EICRA=0x00;
EIMSK=0x00;
PCICR=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=0x00;
// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=0x00;
// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
ADCSRB=0x00;

// SPI initialization
// SPI Type: Master
// SPI Clock Rate: 500.000 kHz
// SPI Clock Phase: Cycle Half
// SPI Clock Polarity: Low
// SPI Data Order: MSB First
SPCR=0x51;
SPSR=0x00;
// I2C Bus initialization
i2c_init();

// DS1307 Real Time Clock initialization
// Square wave output on pin SQW/OUT: Off
// SQW/OUT pin state: 0
rtc_init(0,0,0);
lcd_init();
 clear_lcd();
   delay_ms(800);

    lcd_cmd(0x80);  
   
  
while (1)
      {      
      
    rtc_get_time(&h,&m,&s);
    rtc_get_date(&date, &month, &year);

	 // Place your code here   
         


   while(spi(0)!='$')
   {    
        
        
    itoa(h,hr);
    itoa(m,min);
    itoa(s,sec); 
    
    itoa(date,date1);
    itoa(month,month1);
    itoa(year,year1);
     lcd_cmd(0x80); 
     lcd_puts(tm); 
    lcd_puts(hr); 
    lcd_data(':',0);
      lcd_puts(min);
      lcd_data(':',0);
        lcd_puts(sec);    
         lcd_cmd(0xc0);
         lcd_puts(dt); 
        
         lcd_puts(date1); 
          lcd_data('/',0); 
      lcd_puts(month1);
       lcd_data('/',0); 
        lcd_puts(year1);  
        };
      clear_lcd(); 
      for(i=0; i<16; i++)
      { 
      
   
    lcd_cmd(0x80);	 
  data=spi(0); 
    lcd_data(data,0);     
  
}   
        
          
      }
}
 #include <mega48.h> 
  #include <delay.h>         
//#include <prototype.h> 
#include <lcd16x1.h> 
#include <stdlib.h>
#include <stdio.h>  
//#include<prototype.h>     
//#define INT0_PIN PIND.2         //int0 pin PD.2
//#define INT1_PIN PIND.3         //int1 pin PD.3

#define RS PORTB.0
#define RW PORTB.1    //lcd defines
#define EN PORTB.2  
                        
         

//function to clear the lcd & start from first row first column onwards       
void clear_lcd(void)
{
       lcd_cmd(0x01);
       //lcd_cmd(0x80);   //clear screen n start from fist line first column
       lcd_cmd(0x06);     //incremental cursor
}

//lcd initialization function for 4 datalines    
 void lcd_init(void)
 {
        delay_ms(15);               //startup delay
                  lcd_cmd(0x03);
        delay_ms(5);     
                  lcd_cmd(0x03);
        delay_us(160);     
                  lcd_cmd(0x03);
        delay_us(160);            
                  lcd_cmd(0x02);
       delay_us(160);  
                  lcd_cmd(0x28);         //4 bit data , 5*7, 2 line..   //the abouve cmds are necessary
       delay_ms(100);                    
                  lcd_cmd(0x60);         // set CGRAM addr
       delay_ms(100);           
         lcd_cmd(0x0C); 
       delay_ms(1);                          
                  lcd_cmd(0x06);       //increment cursor no shift
       delay_ms(1);           
                  lcd_cmd(0x90);       // 1st column 1st char
        delay_ms(1);                                        
                  lcd_cmd(0x01);       //clear lcd
        delay_ms(2);                              
  }
  //to send lcd commands
void lcd_cmd(unsigned char inst)
{

       unsigned char lsb=0,msb=0;
        lsb=inst&0x0F;        //split msb n lsb nibbles
        msb=inst>>4; 
        msb&=0x0F;   
        lsb=lsb&0X0F;
        msb=msb<<4;
        lsb=lsb<<4;
        delay_us(500);            //busy check duration       500
        RS=0;
        RW=0;    
        EN=1;     
        PORTD&=0x0F; 
        PORTD|=msb; 
        delay_us(5);         //6 nops       changed from 10u to 5u
        EN=0;
        delay_us(5);         //6 nops
        EN=1;
        PORTD&=0x0F;        //sending lsb now       
        PORTD|=lsb; 
        delay_us(5);         //6 nops
        EN=0;
     }   
               
//function to send data to lcd
 void lcd_data(unsigned char data1,unsigned char type)
 {      
      unsigned char lsbc,msbc,temp,a; 
      type=a;
      temp=0;lsbc=0;msbc=0;
      msbc=data1&0xF0;      //msb n lsb split
      lsbc=data1<<4;
      delay_us(600);            //busy check duration       prev 600
      RS=1;
      RW=0;     
      EN=1;
      PORTD&=0x0F; 
      PORTD|=msbc;         // this being moved to the lsbbits of port instead of msb...
      delay_us(5);        
      EN=0 ;                   
      delay_us(5);        
      EN=1;
      PORTD&=0x0F;
      PORTD|=lsbc;        
      delay_us(5);        
      EN=0;     
} 
            
 
//function to put string onto lcd     
void lcd_puts(unsigned char *str)
{
  while(*str !='\0') 
         {     

           lcd_data(*str,1);
             *str++;
          }
}




//function to convert int to ascii for dispaly on lcd / serial port          
//  //calculate the ascii values to be displayed on lcd  3 digit int to 3 digit ascii
// void cal_ascii(unsigned int value)   
// { 
//        unsigned char lb,mb,mmlb;
//        mmlb=(((unsigned char)(value/100))|0x30);
//        mb=(unsigned char)(value/10);  
//        mb=(((unsigned char)(mb%10))|0x30);
//        lb=(((unsigned char)(value%10))|0x30);
//       
//       if(value>99){ lcd_data(mmlb,1);lcd_data(mb,1);lcd_data(lb,1); }
//       else if (value >9){lcd_data(mb,1);lcd_data(lb,1); }
//       else 
//       {   
//       lcd_data(0x30,1);
//       lcd_data(lb,1); 
//       }
// }                       


