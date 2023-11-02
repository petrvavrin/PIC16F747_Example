//-----------------------------< definice vstupu >-----------------------------
//---- PORT A -----
#define RA0 PORTA.F0 //
#define RA1 PORTA.F1 //
#define RA2 PORTA.F2 //
#define RA3 PORTA.F3 //
#define RA4 PORTA.F4 //
#define RA5 PORTA.F5 //
#define RA6 PORTA.F6 //
#define RA7 PORTA.F7 //

//---- PORT B -----
#define RB0 PORTB.F0 //
#define RB1 PORTB.F1 //
#define RB2 PORTB.F2 //
#define RB3 PORTB.F3 //
#define RB4 PORTB.F4 //
#define RB5 PORTB.F5 //
#define RB6 PORTB.F6 //
#define RB7 PORTB.F7 //

//---- PORT C -----
#define RC0 PORTC.F0 //
#define RC1 PORTC.F1 //
#define RC2 PORTC.F2 //
#define RC3 PORTC.F3 //
#define RC4 PORTC.F4 //
#define RC5 PORTC.F5 //
#define RC6 PORTC.F6 //
#define RC7 PORTC.F7 //

//---- PORT D -----
#define RD0 PORTD.F0 //
#define RD1 PORTD.F1 //
#define RD2 PORTD.F2 //
#define RD3 PORTD.F3 //
#define RD4 PORTD.F4 //
#define RD5 PORTD.F5 //
#define RD6 PORTD.F6 //
#define RD7 PORTD.F7 //

//---- PORT E -----
#define RE0 PORTE.F0 //
#define RE1 PORTE.F1 //
#define RE2 PORTE.F2 //
#define RE3 PORTE.F3 //
//---------------------

// Nokia 5110 LCD module connections - use software SPI, Tato deklarace musi byt jako prvni
#define LCD_RST  RE2_bit  // reset pin, optional!
#define LCD_CS   RE1_bit  // chip select pin, optional!
#define LCD_DC   RE0_bit  // data/command pin
#define LCD_DAT  RA5_bit  // data-in pin (MOSI)
#define LCD_CLK  RA4_bit  // clock pin

#include <NOKIA5110.h>    // include Nokia 5110 LCD driver source file, Tato deklarace musi byt jako druha

/*const uint8_t logo16_glcd_bmp[] = { // declare bmp image located in PIC ROM
  48, 112, 240, 240,  96,  96, 248, 158, 255, 127, 120, 224,
  224, 192, 192, 192,  0,  96, 120, 125,  63,  59,  29,  31,
  61, 123, 255, 243,  1,   1,   0,   0
  };*/
  
//-----------------------------------------------------------------------------
void InitHW(){

 //----                                  // Configure internall oscillator
  //OSCCON = 0b01101110;                   // Set Internal OSC bits
 //----
  PORTA = 0x00;                          // Priprava pro konfiguraci portu PORT A
  PORTB = 0x00;                          // PORT B
  PORTC = 0x00;                          // PORT C
  PORTD = 0x00;                          // PORT D
  PORTE = 0x00;                          // PORT E
 //----
  TRISA = 0b00000000;                    // Nastaveni I/O 0=Output / 1=Input
  TRISB = 0b00000000;                    // PORTB 8-bit I/O
  TRISC = 0b00000000;                    // PORTC 8-bit I/O
  TRISE = 0b00000000;

 } // end Init

 
//--------------------------------------------------------------------------------------
void LED_Blik() {
 RC6 = 1;
 Delay_ms(20);
 RC6 = 0;
 Delay_ms(40);
 RC6 = 1;
 Delay_ms(20);
 RC6 = 0;
 Delay_ms(1000);

}
//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
void main() {
    InitHW();
    LCD_Begin();                                  // initialize the LCD
    LCD_SetContrast(120);                          // set LCD contrast
    LCD_Fill();                                   // test LCD pixels
    LCD_Display();                                // show splashscreen (kyticka logo)
    Delay_ms(500);
    LCD_Clear();                                  // clear the display buffer

    LCD_TextSize(1);                              // set text size to 1
    LCD_TextColor(BLACK, WHITE);                  // set text color to black with white background
    LCD_GotoXY(7, 3);                             // move cursor to position
    LCD_Print("Teplota C");
    LCD_DrawRect(51, 3, 3, 3, BLACK);             // print degree symbol ( ° )
    LCD_DrawRoundRect(0, 0, 84, 48, 7, BLACK);    // obly ramecek
    LCD_Display();
    //------------------------- L O O P -----------------------------
    while (1) {

     LED_Blik();

    }//end loop


 }//end main