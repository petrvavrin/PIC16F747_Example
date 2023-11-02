
_LCD_Write:

;nokia5110.h,254 :: 		void LCD_Write(uint8_t d)
;nokia5110.h,257 :: 		for (bit_n = 0x80; bit_n; bit_n >>= 1) {
	MOVLW       128
	MOVWF       LCD_Write_bit_n_L0+0 
L_LCD_Write0:
	MOVF        LCD_Write_bit_n_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_Write1
;nokia5110.h,258 :: 		LCD_CLK = 0;
	BCF         RA4_bit+0, BitPos(RA4_bit+0) 
;nokia5110.h,259 :: 		if (d & bit_n) LCD_DAT = 1;
	MOVF        LCD_Write_bit_n_L0+0, 0 
	ANDWF       FARG_LCD_Write_d+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_Write3
	BSF         RA5_bit+0, BitPos(RA5_bit+0) 
	GOTO        L_LCD_Write4
L_LCD_Write3:
;nokia5110.h,260 :: 		else           LCD_DAT = 0;
	BCF         RA5_bit+0, BitPos(RA5_bit+0) 
L_LCD_Write4:
;nokia5110.h,261 :: 		LCD_CLK = 1;
	BSF         RA4_bit+0, BitPos(RA4_bit+0) 
;nokia5110.h,257 :: 		for (bit_n = 0x80; bit_n; bit_n >>= 1) {
	RRCF        LCD_Write_bit_n_L0+0, 1 
	BCF         LCD_Write_bit_n_L0+0, 7 
;nokia5110.h,262 :: 		}
	GOTO        L_LCD_Write0
L_LCD_Write1:
;nokia5110.h,263 :: 		}
L_end_LCD_Write:
	RETURN      0
; end of _LCD_Write

_write_command:

;nokia5110.h,266 :: 		void write_command(uint8_t c_)
;nokia5110.h,268 :: 		LCD_DC = 0;
	BCF         RE0_bit+0, BitPos(RE0_bit+0) 
;nokia5110.h,270 :: 		LCD_CS = 0;
	BCF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,272 :: 		LCD_Write(c_);
	MOVF        FARG_write_command_c_+0, 0 
	MOVWF       FARG_LCD_Write_d+0 
	CALL        _LCD_Write+0, 0
;nokia5110.h,274 :: 		LCD_CS = 1;
	BSF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,276 :: 		}
L_end_write_command:
	RETURN      0
; end of _write_command

_write_data:

;nokia5110.h,278 :: 		void write_data(uint8_t d_)
;nokia5110.h,280 :: 		LCD_DC = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;nokia5110.h,282 :: 		LCD_CS = 0;
	BCF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,284 :: 		LCD_Write(d_);
	MOVF        FARG_write_data_d_+0, 0 
	MOVWF       FARG_LCD_Write_d+0 
	CALL        _LCD_Write+0, 0
;nokia5110.h,286 :: 		LCD_CS = 1;
	BSF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,288 :: 		}
L_end_write_data:
	RETURN      0
; end of _write_data

_LCD_Begin:

;nokia5110.h,290 :: 		void LCD_Begin()
;nokia5110.h,292 :: 		Delay_ms(100);
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       81
	MOVWF       R13, 0
L_LCD_Begin5:
	DECFSZ      R13, 1, 1
	BRA         L_LCD_Begin5
	DECFSZ      R12, 1, 1
	BRA         L_LCD_Begin5
	NOP
	NOP
;nokia5110.h,294 :: 		LCD_RST = 0;
	BCF         RE2_bit+0, BitPos(RE2_bit+0) 
;nokia5110.h,299 :: 		Delay_ms(500);
	MOVLW       17
	MOVWF       R12, 0
	MOVLW       158
	MOVWF       R13, 0
L_LCD_Begin6:
	DECFSZ      R13, 1, 1
	BRA         L_LCD_Begin6
	DECFSZ      R12, 1, 1
	BRA         L_LCD_Begin6
;nokia5110.h,300 :: 		LCD_RST = 1;
	BSF         RE2_bit+0, BitPos(RE2_bit+0) 
;nokia5110.h,303 :: 		LCD_CS = 1;
	BSF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,322 :: 		write_command(LCD_FUNCTIONSET | LCD_EXTENDEDINSTRUCTION );
	MOVLW       33
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,325 :: 		write_command(LCD_SETBIAS | 0x03);
	MOVLW       19
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,328 :: 		write_command( LCD_SETVOP | 0x32);
	MOVLW       178
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,331 :: 		write_command(LCD_FUNCTIONSET);
	MOVLW       32
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,334 :: 		write_command(LCD_DISPLAYCONTROL | LCD_DISPLAYNORMAL);
	MOVLW       12
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,336 :: 		LCD_Display();
	CALL        _LCD_Display+0, 0
;nokia5110.h,337 :: 		}
L_end_LCD_Begin:
	RETURN      0
; end of _LCD_Begin

_LCD_SetContrast:

;nokia5110.h,339 :: 		void LCD_SetContrast(uint8_t con)
;nokia5110.h,341 :: 		if (con > 0x7f)
	MOVF        FARG_LCD_SetContrast_con+0, 0 
	SUBLW       127
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_SetContrast7
;nokia5110.h,342 :: 		con = 0x7f;
	MOVLW       127
	MOVWF       FARG_LCD_SetContrast_con+0 
L_LCD_SetContrast7:
;nokia5110.h,344 :: 		write_command(LCD_FUNCTIONSET | LCD_EXTENDEDINSTRUCTION );
	MOVLW       33
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,345 :: 		write_command( LCD_SETVOP | con);
	MOVLW       128
	IORWF       FARG_LCD_SetContrast_con+0, 0 
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,346 :: 		write_command(LCD_FUNCTIONSET);
	MOVLW       32
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,347 :: 		}
L_end_LCD_SetContrast:
	RETURN      0
; end of _LCD_SetContrast

_LCD_Display:

;nokia5110.h,349 :: 		void LCD_Display()
;nokia5110.h,352 :: 		write_command(LCD_SETYADDR);  // set y = 0
	MOVLW       64
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,353 :: 		write_command(LCD_SETXADDR);  // set x = 0
	MOVLW       128
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
;nokia5110.h,355 :: 		LCD_DC = 1;
	BSF         RE0_bit+0, BitPos(RE0_bit+0) 
;nokia5110.h,357 :: 		LCD_CS = 0;
	BCF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,360 :: 		for(i = 0; i < 504; i++)  // 504 = LCDWIDTH*LCDHEIGHT / 8
	CLRF        LCD_Display_i_L0+0 
	CLRF        LCD_Display_i_L0+1 
L_LCD_Display8:
	MOVLW       1
	SUBWF       LCD_Display_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_Display193
	MOVLW       248
	SUBWF       LCD_Display_i_L0+0, 0 
L__LCD_Display193:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Display9
;nokia5110.h,361 :: 		LCD_Write( lcd_buffer[i] );
	MOVLW       _lcd_buffer+0
	ADDWF       LCD_Display_i_L0+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       hi_addr(_lcd_buffer+0)
	ADDWFC      LCD_Display_i_L0+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_LCD_Write_d+0 
	CALL        _LCD_Write+0, 0
;nokia5110.h,360 :: 		for(i = 0; i < 504; i++)  // 504 = LCDWIDTH*LCDHEIGHT / 8
	INFSNZ      LCD_Display_i_L0+0, 1 
	INCF        LCD_Display_i_L0+1, 1 
;nokia5110.h,361 :: 		LCD_Write( lcd_buffer[i] );
	GOTO        L_LCD_Display8
L_LCD_Display9:
;nokia5110.h,364 :: 		LCD_CS = 1;
	BSF         RE1_bit+0, BitPos(RE1_bit+0) 
;nokia5110.h,367 :: 		}
L_end_LCD_Display:
	RETURN      0
; end of _LCD_Display

_LCD_DrawPixel:

;nokia5110.h,369 :: 		void LCD_DrawPixel(uint8_t x, uint8_t y, bool color)
;nokia5110.h,372 :: 		if ( (x >= _width) || (y >= _height) )
	MOVF        __width+0, 0 
	SUBWF       FARG_LCD_DrawPixel_x+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__LCD_DrawPixel179
	MOVF        __height+0, 0 
	SUBWF       FARG_LCD_DrawPixel_y+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__LCD_DrawPixel179
	GOTO        L_LCD_DrawPixel13
L__LCD_DrawPixel179:
;nokia5110.h,373 :: 		return;
	GOTO        L_end_LCD_DrawPixel
L_LCD_DrawPixel13:
;nokia5110.h,374 :: 		switch(rotation) {
	GOTO        L_LCD_DrawPixel14
;nokia5110.h,375 :: 		case 1:
L_LCD_DrawPixel16:
;nokia5110.h,376 :: 		t = x;
	MOVF        FARG_LCD_DrawPixel_x+0, 0 
	MOVWF       LCD_DrawPixel_t_L0+0 
	MOVLW       0
	MOVWF       LCD_DrawPixel_t_L0+1 
;nokia5110.h,377 :: 		x = y;
	MOVF        FARG_LCD_DrawPixel_y+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
;nokia5110.h,378 :: 		y =  LCDHEIGHT - 1 - t;
	MOVF        LCD_DrawPixel_t_L0+0, 0 
	SUBLW       47
	MOVWF       FARG_LCD_DrawPixel_y+0 
;nokia5110.h,379 :: 		break;
	GOTO        L_LCD_DrawPixel15
;nokia5110.h,380 :: 		case 2:
L_LCD_DrawPixel17:
;nokia5110.h,381 :: 		x = LCDWIDTH - 1 - x;
	MOVF        FARG_LCD_DrawPixel_x+0, 0 
	SUBLW       83
	MOVWF       FARG_LCD_DrawPixel_x+0 
;nokia5110.h,382 :: 		y = LCDHEIGHT - 1 - y;
	MOVF        FARG_LCD_DrawPixel_y+0, 0 
	SUBLW       47
	MOVWF       FARG_LCD_DrawPixel_y+0 
;nokia5110.h,383 :: 		break;
	GOTO        L_LCD_DrawPixel15
;nokia5110.h,384 :: 		case 3:
L_LCD_DrawPixel18:
;nokia5110.h,385 :: 		t = x;
	MOVF        FARG_LCD_DrawPixel_x+0, 0 
	MOVWF       LCD_DrawPixel_t_L0+0 
	MOVLW       0
	MOVWF       LCD_DrawPixel_t_L0+1 
;nokia5110.h,386 :: 		x = LCDWIDTH - 1 - y;
	MOVF        FARG_LCD_DrawPixel_y+0, 0 
	SUBLW       83
	MOVWF       FARG_LCD_DrawPixel_x+0 
;nokia5110.h,387 :: 		y = t;
	MOVF        LCD_DrawPixel_t_L0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
;nokia5110.h,388 :: 		break;
	GOTO        L_LCD_DrawPixel15
;nokia5110.h,389 :: 		}
L_LCD_DrawPixel14:
	MOVF        _rotation+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_DrawPixel16
	MOVF        _rotation+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_DrawPixel17
	MOVF        _rotation+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_DrawPixel18
L_LCD_DrawPixel15:
;nokia5110.h,391 :: 		if ((x >= LCDWIDTH) || (y >= LCDHEIGHT))
	MOVLW       84
	SUBWF       FARG_LCD_DrawPixel_x+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__LCD_DrawPixel178
	MOVLW       48
	SUBWF       FARG_LCD_DrawPixel_y+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__LCD_DrawPixel178
	GOTO        L_LCD_DrawPixel21
L__LCD_DrawPixel178:
;nokia5110.h,392 :: 		return;
	GOTO        L_end_LCD_DrawPixel
L_LCD_DrawPixel21:
;nokia5110.h,394 :: 		if (color)
	MOVF        FARG_LCD_DrawPixel_color+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_DrawPixel22
;nokia5110.h,395 :: 		lcd_buffer[x + (uint16_t)(y / 8) * LCDWIDTH] |=  (1 << (y & 7));
	MOVLW       8
	MOVWF       R4 
	MOVF        FARG_LCD_DrawPixel_y+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVLW       84
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_LCD_DrawPixel_x+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _lcd_buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_lcd_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       7
	ANDWF       FARG_LCD_DrawPixel_y+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__LCD_DrawPixel195:
	BZ          L__LCD_DrawPixel196
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__LCD_DrawPixel195
L__LCD_DrawPixel196:
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVF        POSTINC0+0, 0 
	IORWF       R0, 1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_LCD_DrawPixel23
L_LCD_DrawPixel22:
;nokia5110.h,398 :: 		lcd_buffer[x + (uint16_t)(y / 8) * LCDWIDTH] &=  ~(1 << (y & 7));
	MOVLW       8
	MOVWF       R4 
	MOVF        FARG_LCD_DrawPixel_y+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       0
	MOVWF       R1 
	MOVLW       84
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FARG_LCD_DrawPixel_x+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _lcd_buffer+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_lcd_buffer+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       7
	ANDWF       FARG_LCD_DrawPixel_y+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R1 
	MOVLW       1
	MOVWF       R0 
	MOVF        R1, 0 
L__LCD_DrawPixel197:
	BZ          L__LCD_DrawPixel198
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__LCD_DrawPixel197
L__LCD_DrawPixel198:
	COMF        R0, 1 
	MOVFF       R2, FSR0L+0
	MOVFF       R3, FSR0H+0
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVFF       R2, FSR1L+0
	MOVFF       R3, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_LCD_DrawPixel23:
;nokia5110.h,399 :: 		}
L_end_LCD_DrawPixel:
	RETURN      0
; end of _LCD_DrawPixel

_LCD_DrawLine:

;nokia5110.h,401 :: 		void LCD_DrawLine(int16_t x0, int16_t y0, int16_t x1, int16_t y1, bool color)
;nokia5110.h,407 :: 		steep = abs(y1 - y0) > abs(x1 - x0);
	MOVF        FARG_LCD_DrawLine_y0+0, 0 
	SUBWF       FARG_LCD_DrawLine_y1+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_LCD_DrawLine_y0+1, 0 
	SUBWFB      FARG_LCD_DrawLine_y1+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LCD_DrawLine+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LCD_DrawLine+1 
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	SUBWF       FARG_LCD_DrawLine_x1+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_LCD_DrawLine_x0+1, 0 
	SUBWFB      FARG_LCD_DrawLine_x1+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       LCD_DrawLine_steep_L0+0 
	MOVLW       128
	XORWF       FLOC__LCD_DrawLine+1, 0 
	SUBWF       LCD_DrawLine_steep_L0+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawLine200
	MOVF        FLOC__LCD_DrawLine+0, 0 
	SUBWF       R0, 0 
L__LCD_DrawLine200:
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       LCD_DrawLine_steep_L0+0 
;nokia5110.h,408 :: 		if (steep) {
	MOVF        LCD_DrawLine_steep_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_DrawLine24
;nokia5110.h,409 :: 		LCD_swap(x0, y0);
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	MOVWF       LCD_DrawLine_t_L2+0 
	MOVF        FARG_LCD_DrawLine_x0+1, 0 
	MOVWF       LCD_DrawLine_t_L2+1 
	MOVF        FARG_LCD_DrawLine_y0+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVF        FARG_LCD_DrawLine_y0+1, 0 
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        LCD_DrawLine_t_L2+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVF        LCD_DrawLine_t_L2+1, 0 
	MOVWF       FARG_LCD_DrawLine_y0+1 
;nokia5110.h,410 :: 		LCD_swap(x1, y1);
	MOVF        FARG_LCD_DrawLine_x1+0, 0 
	MOVWF       LCD_DrawLine_t_L2_L2+0 
	MOVF        FARG_LCD_DrawLine_x1+1, 0 
	MOVWF       LCD_DrawLine_t_L2_L2+1 
	MOVF        FARG_LCD_DrawLine_y1+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	MOVF        FARG_LCD_DrawLine_y1+1, 0 
	MOVWF       FARG_LCD_DrawLine_x1+1 
	MOVF        LCD_DrawLine_t_L2_L2+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	MOVF        LCD_DrawLine_t_L2_L2+1, 0 
	MOVWF       FARG_LCD_DrawLine_y1+1 
;nokia5110.h,411 :: 		}
L_LCD_DrawLine24:
;nokia5110.h,412 :: 		if (x0 > x1) {
	MOVLW       128
	XORWF       FARG_LCD_DrawLine_x1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_DrawLine_x0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawLine201
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	SUBWF       FARG_LCD_DrawLine_x1+0, 0 
L__LCD_DrawLine201:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawLine25
;nokia5110.h,413 :: 		LCD_swap(x0, x1);
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	MOVWF       LCD_DrawLine_t_L2_L2_L2+0 
	MOVF        FARG_LCD_DrawLine_x0+1, 0 
	MOVWF       LCD_DrawLine_t_L2_L2_L2+1 
	MOVF        FARG_LCD_DrawLine_x1+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVF        FARG_LCD_DrawLine_x1+1, 0 
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        LCD_DrawLine_t_L2_L2_L2+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	MOVF        LCD_DrawLine_t_L2_L2_L2+1, 0 
	MOVWF       FARG_LCD_DrawLine_x1+1 
;nokia5110.h,414 :: 		LCD_swap(y0, y1);
	MOVF        FARG_LCD_DrawLine_y0+0, 0 
	MOVWF       LCD_DrawLine_t_L2_L2_L2_L2+0 
	MOVF        FARG_LCD_DrawLine_y0+1, 0 
	MOVWF       LCD_DrawLine_t_L2_L2_L2_L2+1 
	MOVF        FARG_LCD_DrawLine_y1+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVF        FARG_LCD_DrawLine_y1+1, 0 
	MOVWF       FARG_LCD_DrawLine_y0+1 
	MOVF        LCD_DrawLine_t_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	MOVF        LCD_DrawLine_t_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_LCD_DrawLine_y1+1 
;nokia5110.h,415 :: 		}
L_LCD_DrawLine25:
;nokia5110.h,416 :: 		dx = x1 - x0;
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	SUBWF       FARG_LCD_DrawLine_x1+0, 0 
	MOVWF       LCD_DrawLine_dx_L0+0 
;nokia5110.h,417 :: 		dy = abs(y1 - y0);
	MOVF        FARG_LCD_DrawLine_y0+0, 0 
	SUBWF       FARG_LCD_DrawLine_y1+0, 0 
	MOVWF       FARG_abs_a+0 
	MOVF        FARG_LCD_DrawLine_y0+1, 0 
	SUBWFB      FARG_LCD_DrawLine_y1+1, 0 
	MOVWF       FARG_abs_a+1 
	CALL        _abs+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_DrawLine_dy_L0+0 
;nokia5110.h,419 :: 		err = dx / 2;
	MOVLW       2
	MOVWF       R4 
	MOVF        LCD_DrawLine_dx_L0+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_DrawLine_err_L0+0 
	MOVLW       0
	MOVWF       LCD_DrawLine_err_L0+1 
;nokia5110.h,420 :: 		if (y0 < y1)
	MOVLW       128
	XORWF       FARG_LCD_DrawLine_y0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_DrawLine_y1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawLine202
	MOVF        FARG_LCD_DrawLine_y1+0, 0 
	SUBWF       FARG_LCD_DrawLine_y0+0, 0 
L__LCD_DrawLine202:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawLine26
;nokia5110.h,421 :: 		ystep = 1;
	MOVLW       1
	MOVWF       LCD_DrawLine_ystep_L0+0 
	GOTO        L_LCD_DrawLine27
L_LCD_DrawLine26:
;nokia5110.h,423 :: 		ystep = -1;
	MOVLW       255
	MOVWF       LCD_DrawLine_ystep_L0+0 
L_LCD_DrawLine27:
;nokia5110.h,425 :: 		for (; x0 <= x1; x0++) {
L_LCD_DrawLine28:
	MOVLW       128
	XORWF       FARG_LCD_DrawLine_x1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_DrawLine_x0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawLine203
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	SUBWF       FARG_LCD_DrawLine_x1+0, 0 
L__LCD_DrawLine203:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_DrawLine29
;nokia5110.h,426 :: 		if (steep)
	MOVF        LCD_DrawLine_steep_L0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_DrawLine31
;nokia5110.h,427 :: 		LCD_DrawPixel(y0, x0, color);
	MOVF        FARG_LCD_DrawLine_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawLine_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
	GOTO        L_LCD_DrawLine32
L_LCD_DrawLine31:
;nokia5110.h,429 :: 		LCD_DrawPixel(x0, y0, color);
	MOVF        FARG_LCD_DrawLine_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        FARG_LCD_DrawLine_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawLine_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
L_LCD_DrawLine32:
;nokia5110.h,430 :: 		err -= dy;
	MOVF        LCD_DrawLine_dy_L0+0, 0 
	SUBWF       LCD_DrawLine_err_L0+0, 1 
	MOVLW       0
	SUBWFB      LCD_DrawLine_err_L0+1, 1 
;nokia5110.h,431 :: 		if (err < 0) {
	MOVLW       128
	XORWF       LCD_DrawLine_err_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawLine204
	MOVLW       0
	SUBWF       LCD_DrawLine_err_L0+0, 0 
L__LCD_DrawLine204:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawLine33
;nokia5110.h,432 :: 		y0  += ystep;
	MOVF        LCD_DrawLine_ystep_L0+0, 0 
	ADDWF       FARG_LCD_DrawLine_y0+0, 1 
	MOVLW       0
	BTFSC       LCD_DrawLine_ystep_L0+0, 7 
	MOVLW       255
	ADDWFC      FARG_LCD_DrawLine_y0+1, 1 
;nokia5110.h,433 :: 		err += dx;
	MOVF        LCD_DrawLine_dx_L0+0, 0 
	ADDWF       LCD_DrawLine_err_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_DrawLine_err_L0+1, 1 
;nokia5110.h,434 :: 		}
L_LCD_DrawLine33:
;nokia5110.h,425 :: 		for (; x0 <= x1; x0++) {
	INFSNZ      FARG_LCD_DrawLine_x0+0, 1 
	INCF        FARG_LCD_DrawLine_x0+1, 1 
;nokia5110.h,435 :: 		}
	GOTO        L_LCD_DrawLine28
L_LCD_DrawLine29:
;nokia5110.h,436 :: 		}
L_end_LCD_DrawLine:
	RETURN      0
; end of _LCD_DrawLine

_LCD_DrawHLine:

;nokia5110.h,438 :: 		void LCD_DrawHLine(uint8_t x, uint8_t y, uint8_t w, bool color)
;nokia5110.h,440 :: 		LCD_DrawLine(x, y, x + w - 1, y, color);
	MOVF        FARG_LCD_DrawHLine_x+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        FARG_LCD_DrawHLine_y+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y0+1 
	MOVF        FARG_LCD_DrawHLine_w+0, 0 
	ADDWF       FARG_LCD_DrawHLine_x+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	CLRF        FARG_LCD_DrawLine_x1+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawLine_x1+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_DrawLine_x1+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawLine_x1+1, 1 
	MOVF        FARG_LCD_DrawHLine_y+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y1+1 
	MOVF        FARG_LCD_DrawHLine_color+0, 0 
	MOVWF       FARG_LCD_DrawLine_color+0 
	CALL        _LCD_DrawLine+0, 0
;nokia5110.h,441 :: 		}
L_end_LCD_DrawHLine:
	RETURN      0
; end of _LCD_DrawHLine

_LCD_DrawVLine:

;nokia5110.h,443 :: 		void LCD_DrawVLine(uint8_t x, uint8_t y, uint8_t h, bool color)
;nokia5110.h,445 :: 		LCD_DrawLine(x, y, x, y + h - 1, color);
	MOVF        FARG_LCD_DrawVLine_x+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        FARG_LCD_DrawVLine_y+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y0+1 
	MOVF        FARG_LCD_DrawVLine_x+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x1+1 
	MOVF        FARG_LCD_DrawVLine_h+0, 0 
	ADDWF       FARG_LCD_DrawVLine_y+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	CLRF        FARG_LCD_DrawLine_y1+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawLine_y1+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_DrawLine_y1+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawLine_y1+1, 1 
	MOVF        FARG_LCD_DrawVLine_color+0, 0 
	MOVWF       FARG_LCD_DrawLine_color+0 
	CALL        _LCD_DrawLine+0, 0
;nokia5110.h,446 :: 		}
L_end_LCD_DrawVLine:
	RETURN      0
; end of _LCD_DrawVLine

_LCD_FillRect:

;nokia5110.h,448 :: 		void LCD_FillRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, bool color)
;nokia5110.h,451 :: 		for (i = x; i < x + w; i++)
	MOVF        FARG_LCD_FillRect_x+0, 0 
	MOVWF       LCD_FillRect_i_L0+0 
	MOVLW       0
	MOVWF       LCD_FillRect_i_L0+1 
L_LCD_FillRect34:
	MOVF        FARG_LCD_FillRect_w+0, 0 
	ADDWF       FARG_LCD_FillRect_x+0, 0 
	MOVWF       R1 
	CLRF        R2 
	MOVLW       0
	ADDWFC      R2, 1 
	MOVLW       128
	XORWF       LCD_FillRect_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillRect208
	MOVF        R1, 0 
	SUBWF       LCD_FillRect_i_L0+0, 0 
L__LCD_FillRect208:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillRect35
;nokia5110.h,452 :: 		LCD_DrawVLine(i, y, h, color);
	MOVF        LCD_FillRect_i_L0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        FARG_LCD_FillRect_y+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVF        FARG_LCD_FillRect_h+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        FARG_LCD_FillRect_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,451 :: 		for (i = x; i < x + w; i++)
	INFSNZ      LCD_FillRect_i_L0+0, 1 
	INCF        LCD_FillRect_i_L0+1, 1 
;nokia5110.h,452 :: 		LCD_DrawVLine(i, y, h, color);
	GOTO        L_LCD_FillRect34
L_LCD_FillRect35:
;nokia5110.h,453 :: 		}
L_end_LCD_FillRect:
	RETURN      0
; end of _LCD_FillRect

_LCD_DrawCircle:

;nokia5110.h,455 :: 		void LCD_DrawCircle(int16_t x0, int16_t y0, int16_t r, bool color)
;nokia5110.h,457 :: 		int16_t f = 1 - r;
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	SUBLW       1
	MOVWF       LCD_DrawCircle_f_L0+0 
	MOVF        FARG_LCD_DrawCircle_r+1, 0 
	MOVWF       LCD_DrawCircle_f_L0+1 
	MOVLW       0
	SUBFWB      LCD_DrawCircle_f_L0+1, 1 
;nokia5110.h,458 :: 		int16_t ddF_x = 1;
	MOVLW       1
	MOVWF       LCD_DrawCircle_ddF_x_L0+0 
	MOVLW       0
	MOVWF       LCD_DrawCircle_ddF_x_L0+1 
;nokia5110.h,459 :: 		int16_t ddF_y = -2 * r;
	MOVLW       254
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_LCD_DrawCircle_r+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_DrawCircle_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       LCD_DrawCircle_ddF_y_L0+1 
;nokia5110.h,460 :: 		int16_t x = 0;
	CLRF        LCD_DrawCircle_x_L0+0 
	CLRF        LCD_DrawCircle_x_L0+1 
;nokia5110.h,461 :: 		int16_t y = r;
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	MOVWF       LCD_DrawCircle_y_L0+0 
	MOVF        FARG_LCD_DrawCircle_r+1, 0 
	MOVWF       LCD_DrawCircle_y_L0+1 
;nokia5110.h,463 :: 		LCD_DrawPixel(x0  , y0 + r, color);
	MOVF        FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	ADDWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,464 :: 		LCD_DrawPixel(x0  , y0 - r, color);
	MOVF        FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	SUBWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,465 :: 		LCD_DrawPixel(x0 + r, y0, color);
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	ADDWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,466 :: 		LCD_DrawPixel(x0 - r, y0, color);
	MOVF        FARG_LCD_DrawCircle_r+0, 0 
	SUBWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,468 :: 		while (x < y) {
L_LCD_DrawCircle37:
	MOVLW       128
	XORWF       LCD_DrawCircle_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_DrawCircle_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawCircle210
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	SUBWF       LCD_DrawCircle_x_L0+0, 0 
L__LCD_DrawCircle210:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawCircle38
;nokia5110.h,469 :: 		if (f >= 0) {
	MOVLW       128
	XORWF       LCD_DrawCircle_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawCircle211
	MOVLW       0
	SUBWF       LCD_DrawCircle_f_L0+0, 0 
L__LCD_DrawCircle211:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_DrawCircle39
;nokia5110.h,470 :: 		y--;
	MOVLW       1
	SUBWF       LCD_DrawCircle_y_L0+0, 1 
	MOVLW       0
	SUBWFB      LCD_DrawCircle_y_L0+1, 1 
;nokia5110.h,471 :: 		ddF_y += 2;
	MOVLW       2
	ADDWF       LCD_DrawCircle_ddF_y_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_DrawCircle_ddF_y_L0+1, 1 
;nokia5110.h,472 :: 		f += ddF_y;
	MOVF        LCD_DrawCircle_ddF_y_L0+0, 0 
	ADDWF       LCD_DrawCircle_f_L0+0, 1 
	MOVF        LCD_DrawCircle_ddF_y_L0+1, 0 
	ADDWFC      LCD_DrawCircle_f_L0+1, 1 
;nokia5110.h,473 :: 		}
L_LCD_DrawCircle39:
;nokia5110.h,474 :: 		x++;
	INFSNZ      LCD_DrawCircle_x_L0+0, 1 
	INCF        LCD_DrawCircle_x_L0+1, 1 
;nokia5110.h,475 :: 		ddF_x += 2;
	MOVLW       2
	ADDWF       LCD_DrawCircle_ddF_x_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_DrawCircle_ddF_x_L0+1, 1 
;nokia5110.h,476 :: 		f += ddF_x;
	MOVF        LCD_DrawCircle_ddF_x_L0+0, 0 
	ADDWF       LCD_DrawCircle_f_L0+0, 1 
	MOVF        LCD_DrawCircle_ddF_x_L0+1, 0 
	ADDWFC      LCD_DrawCircle_f_L0+1, 1 
;nokia5110.h,478 :: 		LCD_DrawPixel(x0 + x, y0 + y, color);
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,479 :: 		LCD_DrawPixel(x0 - x, y0 + y, color);
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,480 :: 		LCD_DrawPixel(x0 + x, y0 - y, color);
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,481 :: 		LCD_DrawPixel(x0 - x, y0 - y, color);
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,482 :: 		LCD_DrawPixel(x0 + y, y0 + x, color);
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,483 :: 		LCD_DrawPixel(x0 - y, y0 + x, color);
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,484 :: 		LCD_DrawPixel(x0 + y, y0 - x, color);
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,485 :: 		LCD_DrawPixel(x0 - y, y0 - x, color);
	MOVF        LCD_DrawCircle_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircle_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,486 :: 		}
	GOTO        L_LCD_DrawCircle37
L_LCD_DrawCircle38:
;nokia5110.h,488 :: 		}
L_end_LCD_DrawCircle:
	RETURN      0
; end of _LCD_DrawCircle

_LCD_DrawCircleHelper:

;nokia5110.h,490 :: 		void LCD_DrawCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername, bool color)
;nokia5110.h,492 :: 		int16_t f     = 1 - r;
	MOVF        FARG_LCD_DrawCircleHelper_r+0, 0 
	SUBLW       1
	MOVWF       LCD_DrawCircleHelper_f_L0+0 
	MOVF        FARG_LCD_DrawCircleHelper_r+1, 0 
	MOVWF       LCD_DrawCircleHelper_f_L0+1 
	MOVLW       0
	SUBFWB      LCD_DrawCircleHelper_f_L0+1, 1 
;nokia5110.h,493 :: 		int16_t ddF_x = 1;
	MOVLW       1
	MOVWF       LCD_DrawCircleHelper_ddF_x_L0+0 
	MOVLW       0
	MOVWF       LCD_DrawCircleHelper_ddF_x_L0+1 
;nokia5110.h,494 :: 		int16_t ddF_y = r * (-2);
	MOVF        FARG_LCD_DrawCircleHelper_r+0, 0 
	MOVWF       R0 
	MOVF        FARG_LCD_DrawCircleHelper_r+1, 0 
	MOVWF       R1 
	MOVLW       254
	MOVWF       R4 
	MOVLW       255
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_DrawCircleHelper_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       LCD_DrawCircleHelper_ddF_y_L0+1 
;nokia5110.h,495 :: 		int16_t x     = 0;
	CLRF        LCD_DrawCircleHelper_x_L0+0 
	CLRF        LCD_DrawCircleHelper_x_L0+1 
;nokia5110.h,496 :: 		int16_t y     = r;
	MOVF        FARG_LCD_DrawCircleHelper_r+0, 0 
	MOVWF       LCD_DrawCircleHelper_y_L0+0 
	MOVF        FARG_LCD_DrawCircleHelper_r+1, 0 
	MOVWF       LCD_DrawCircleHelper_y_L0+1 
;nokia5110.h,498 :: 		while (x < y) {
L_LCD_DrawCircleHelper40:
	MOVLW       128
	XORWF       LCD_DrawCircleHelper_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_DrawCircleHelper_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawCircleHelper213
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	SUBWF       LCD_DrawCircleHelper_x_L0+0, 0 
L__LCD_DrawCircleHelper213:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawCircleHelper41
;nokia5110.h,499 :: 		if (f >= 0) {
	MOVLW       128
	XORWF       LCD_DrawCircleHelper_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawCircleHelper214
	MOVLW       0
	SUBWF       LCD_DrawCircleHelper_f_L0+0, 0 
L__LCD_DrawCircleHelper214:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_DrawCircleHelper42
;nokia5110.h,500 :: 		y--;
	MOVLW       1
	SUBWF       LCD_DrawCircleHelper_y_L0+0, 1 
	MOVLW       0
	SUBWFB      LCD_DrawCircleHelper_y_L0+1, 1 
;nokia5110.h,501 :: 		ddF_y += 2;
	MOVLW       2
	ADDWF       LCD_DrawCircleHelper_ddF_y_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_DrawCircleHelper_ddF_y_L0+1, 1 
;nokia5110.h,502 :: 		f     += ddF_y;
	MOVF        LCD_DrawCircleHelper_ddF_y_L0+0, 0 
	ADDWF       LCD_DrawCircleHelper_f_L0+0, 1 
	MOVF        LCD_DrawCircleHelper_ddF_y_L0+1, 0 
	ADDWFC      LCD_DrawCircleHelper_f_L0+1, 1 
;nokia5110.h,503 :: 		}
L_LCD_DrawCircleHelper42:
;nokia5110.h,504 :: 		x++;
	INFSNZ      LCD_DrawCircleHelper_x_L0+0, 1 
	INCF        LCD_DrawCircleHelper_x_L0+1, 1 
;nokia5110.h,505 :: 		ddF_x += 2;
	MOVLW       2
	ADDWF       LCD_DrawCircleHelper_ddF_x_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_DrawCircleHelper_ddF_x_L0+1, 1 
;nokia5110.h,506 :: 		f     += ddF_x;
	MOVF        LCD_DrawCircleHelper_ddF_x_L0+0, 0 
	ADDWF       LCD_DrawCircleHelper_f_L0+0, 1 
	MOVF        LCD_DrawCircleHelper_ddF_x_L0+1, 0 
	ADDWFC      LCD_DrawCircleHelper_f_L0+1, 1 
;nokia5110.h,507 :: 		if (cornername & 0x4) {
	BTFSS       FARG_LCD_DrawCircleHelper_cornername+0, 2 
	GOTO        L_LCD_DrawCircleHelper43
;nokia5110.h,508 :: 		LCD_DrawPixel(x0 + x, y0 + y, color);
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,509 :: 		LCD_DrawPixel(x0 + y, y0 + x, color);
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,510 :: 		}
L_LCD_DrawCircleHelper43:
;nokia5110.h,511 :: 		if (cornername & 0x2) {
	BTFSS       FARG_LCD_DrawCircleHelper_cornername+0, 1 
	GOTO        L_LCD_DrawCircleHelper44
;nokia5110.h,512 :: 		LCD_DrawPixel(x0 + x, y0 - y, color);
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,513 :: 		LCD_DrawPixel(x0 + y, y0 - x, color);
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,514 :: 		}
L_LCD_DrawCircleHelper44:
;nokia5110.h,515 :: 		if (cornername & 0x8) {
	BTFSS       FARG_LCD_DrawCircleHelper_cornername+0, 3 
	GOTO        L_LCD_DrawCircleHelper45
;nokia5110.h,516 :: 		LCD_DrawPixel(x0 - y, y0 + x, color);
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,517 :: 		LCD_DrawPixel(x0 - x, y0 + y, color);
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	ADDWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,518 :: 		}
L_LCD_DrawCircleHelper45:
;nokia5110.h,519 :: 		if (cornername & 0x1) {
	BTFSS       FARG_LCD_DrawCircleHelper_cornername+0, 0 
	GOTO        L_LCD_DrawCircleHelper46
;nokia5110.h,520 :: 		LCD_DrawPixel(x0 - y, y0 - x, color);
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,521 :: 		LCD_DrawPixel(x0 - x, y0 - y, color);
	MOVF        LCD_DrawCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_DrawCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        FARG_LCD_DrawCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
;nokia5110.h,522 :: 		}
L_LCD_DrawCircleHelper46:
;nokia5110.h,523 :: 		}
	GOTO        L_LCD_DrawCircleHelper40
L_LCD_DrawCircleHelper41:
;nokia5110.h,525 :: 		}
L_end_LCD_DrawCircleHelper:
	RETURN      0
; end of _LCD_DrawCircleHelper

_LCD_FillCircleHelper:

;nokia5110.h,528 :: 		void LCD_FillCircleHelper(int16_t x0, int16_t y0, int16_t r, uint8_t cornername, int16_t delta, bool color)
;nokia5110.h,530 :: 		int16_t f     = 1 - r;
	MOVF        FARG_LCD_FillCircleHelper_r+0, 0 
	SUBLW       1
	MOVWF       LCD_FillCircleHelper_f_L0+0 
	MOVF        FARG_LCD_FillCircleHelper_r+1, 0 
	MOVWF       LCD_FillCircleHelper_f_L0+1 
	MOVLW       0
	SUBFWB      LCD_FillCircleHelper_f_L0+1, 1 
;nokia5110.h,531 :: 		int16_t ddF_x = 1;
	MOVLW       1
	MOVWF       LCD_FillCircleHelper_ddF_x_L0+0 
	MOVLW       0
	MOVWF       LCD_FillCircleHelper_ddF_x_L0+1 
;nokia5110.h,532 :: 		int16_t ddF_y = -2 * r;
	MOVLW       254
	MOVWF       R0 
	MOVLW       255
	MOVWF       R1 
	MOVF        FARG_LCD_FillCircleHelper_r+0, 0 
	MOVWF       R4 
	MOVF        FARG_LCD_FillCircleHelper_r+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_FillCircleHelper_ddF_y_L0+0 
	MOVF        R1, 0 
	MOVWF       LCD_FillCircleHelper_ddF_y_L0+1 
;nokia5110.h,533 :: 		int16_t x     = 0;
	CLRF        LCD_FillCircleHelper_x_L0+0 
	CLRF        LCD_FillCircleHelper_x_L0+1 
;nokia5110.h,534 :: 		int16_t y     = r;
	MOVF        FARG_LCD_FillCircleHelper_r+0, 0 
	MOVWF       LCD_FillCircleHelper_y_L0+0 
	MOVF        FARG_LCD_FillCircleHelper_r+1, 0 
	MOVWF       LCD_FillCircleHelper_y_L0+1 
;nokia5110.h,536 :: 		while (x < y) {
L_LCD_FillCircleHelper47:
	MOVLW       128
	XORWF       LCD_FillCircleHelper_x_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillCircleHelper_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillCircleHelper216
	MOVF        LCD_FillCircleHelper_y_L0+0, 0 
	SUBWF       LCD_FillCircleHelper_x_L0+0, 0 
L__LCD_FillCircleHelper216:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillCircleHelper48
;nokia5110.h,537 :: 		if (f >= 0) {
	MOVLW       128
	XORWF       LCD_FillCircleHelper_f_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillCircleHelper217
	MOVLW       0
	SUBWF       LCD_FillCircleHelper_f_L0+0, 0 
L__LCD_FillCircleHelper217:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_FillCircleHelper49
;nokia5110.h,538 :: 		y--;
	MOVLW       1
	SUBWF       LCD_FillCircleHelper_y_L0+0, 1 
	MOVLW       0
	SUBWFB      LCD_FillCircleHelper_y_L0+1, 1 
;nokia5110.h,539 :: 		ddF_y += 2;
	MOVLW       2
	ADDWF       LCD_FillCircleHelper_ddF_y_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_FillCircleHelper_ddF_y_L0+1, 1 
;nokia5110.h,540 :: 		f     += ddF_y;
	MOVF        LCD_FillCircleHelper_ddF_y_L0+0, 0 
	ADDWF       LCD_FillCircleHelper_f_L0+0, 1 
	MOVF        LCD_FillCircleHelper_ddF_y_L0+1, 0 
	ADDWFC      LCD_FillCircleHelper_f_L0+1, 1 
;nokia5110.h,541 :: 		}
L_LCD_FillCircleHelper49:
;nokia5110.h,542 :: 		x++;
	INFSNZ      LCD_FillCircleHelper_x_L0+0, 1 
	INCF        LCD_FillCircleHelper_x_L0+1, 1 
;nokia5110.h,543 :: 		ddF_x += 2;
	MOVLW       2
	ADDWF       LCD_FillCircleHelper_ddF_x_L0+0, 1 
	MOVLW       0
	ADDWFC      LCD_FillCircleHelper_ddF_x_L0+1, 1 
;nokia5110.h,544 :: 		f     += ddF_x;
	MOVF        LCD_FillCircleHelper_ddF_x_L0+0, 0 
	ADDWF       LCD_FillCircleHelper_f_L0+0, 1 
	MOVF        LCD_FillCircleHelper_ddF_x_L0+1, 0 
	ADDWFC      LCD_FillCircleHelper_f_L0+1, 1 
;nokia5110.h,546 :: 		if (cornername & 0x01) {
	BTFSS       FARG_LCD_FillCircleHelper_cornername+0, 0 
	GOTO        L_LCD_FillCircleHelper50
;nokia5110.h,547 :: 		LCD_DrawVLine(x0 + x, y0 - y, 2 * y + 1 + delta, color);
	MOVF        LCD_FillCircleHelper_x_L0+0, 0 
	ADDWF       FARG_LCD_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        LCD_FillCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       LCD_FillCircleHelper_y_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	INCF        FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,548 :: 		LCD_DrawVLine(x0 + y, y0 - x, 2 * x + 1 + delta, color);
	MOVF        LCD_FillCircleHelper_y_L0+0, 0 
	ADDWF       FARG_LCD_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        LCD_FillCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       LCD_FillCircleHelper_x_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	INCF        FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,549 :: 		}
L_LCD_FillCircleHelper50:
;nokia5110.h,550 :: 		if (cornername & 0x02) {
	BTFSS       FARG_LCD_FillCircleHelper_cornername+0, 1 
	GOTO        L_LCD_FillCircleHelper51
;nokia5110.h,551 :: 		LCD_DrawVLine(x0 - x, y0 - y, 2 * y + 1 + delta, color);
	MOVF        LCD_FillCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        LCD_FillCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       LCD_FillCircleHelper_y_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	INCF        FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,552 :: 		LCD_DrawVLine(x0 - y, y0 - x, 2 * x + 1 + delta, color);
	MOVF        LCD_FillCircleHelper_y_L0+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_x0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        LCD_FillCircleHelper_x_L0+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_y0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       LCD_FillCircleHelper_x_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	INCF        FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_delta+0, 0 
	ADDWF       FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircleHelper_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,553 :: 		}
L_LCD_FillCircleHelper51:
;nokia5110.h,554 :: 		}
	GOTO        L_LCD_FillCircleHelper47
L_LCD_FillCircleHelper48:
;nokia5110.h,556 :: 		}
L_end_LCD_FillCircleHelper:
	RETURN      0
; end of _LCD_FillCircleHelper

_LCD_FillCircle:

;nokia5110.h,558 :: 		void LCD_FillCircle(int16_t x0, int16_t y0, int16_t r, bool color)
;nokia5110.h,560 :: 		LCD_DrawVLine(x0, y0 - r, 2 * r + 1, color);
	MOVF        FARG_LCD_FillCircle_x0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        FARG_LCD_FillCircle_r+0, 0 
	SUBWF       FARG_LCD_FillCircle_y0+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       FARG_LCD_FillCircle_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	INCF        FARG_LCD_DrawVLine_h+0, 1 
	MOVF        FARG_LCD_FillCircle_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,561 :: 		LCD_FillCircleHelper(x0, y0, r, 3, 0, color);
	MOVF        FARG_LCD_FillCircle_x0+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_x0+0 
	MOVF        FARG_LCD_FillCircle_x0+1, 0 
	MOVWF       FARG_LCD_FillCircleHelper_x0+1 
	MOVF        FARG_LCD_FillCircle_y0+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_y0+0 
	MOVF        FARG_LCD_FillCircle_y0+1, 0 
	MOVWF       FARG_LCD_FillCircleHelper_y0+1 
	MOVF        FARG_LCD_FillCircle_r+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_r+0 
	MOVF        FARG_LCD_FillCircle_r+1, 0 
	MOVWF       FARG_LCD_FillCircleHelper_r+1 
	MOVLW       3
	MOVWF       FARG_LCD_FillCircleHelper_cornername+0 
	CLRF        FARG_LCD_FillCircleHelper_delta+0 
	CLRF        FARG_LCD_FillCircleHelper_delta+1 
	MOVF        FARG_LCD_FillCircle_color+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_color+0 
	CALL        _LCD_FillCircleHelper+0, 0
;nokia5110.h,562 :: 		}
L_end_LCD_FillCircle:
	RETURN      0
; end of _LCD_FillCircle

_LCD_DrawRect:

;nokia5110.h,565 :: 		void LCD_DrawRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, bool color)
;nokia5110.h,567 :: 		LCD_DrawHLine(x, y, w, color);
	MOVF        FARG_LCD_DrawRect_x+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        FARG_LCD_DrawRect_y+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	MOVF        FARG_LCD_DrawRect_w+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	MOVF        FARG_LCD_DrawRect_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,568 :: 		LCD_DrawHLine(x, y + h - 1, w, color);
	MOVF        FARG_LCD_DrawRect_x+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        FARG_LCD_DrawRect_h+0, 0 
	ADDWF       FARG_LCD_DrawRect_y+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	DECF        FARG_LCD_DrawHLine_y+0, 1 
	MOVF        FARG_LCD_DrawRect_w+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	MOVF        FARG_LCD_DrawRect_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,569 :: 		LCD_DrawVLine(x, y, h, color);
	MOVF        FARG_LCD_DrawRect_x+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        FARG_LCD_DrawRect_y+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVF        FARG_LCD_DrawRect_h+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        FARG_LCD_DrawRect_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,570 :: 		LCD_DrawVLine(x + w - 1, y, h, color);
	MOVF        FARG_LCD_DrawRect_w+0, 0 
	ADDWF       FARG_LCD_DrawRect_x+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	DECF        FARG_LCD_DrawVLine_x+0, 1 
	MOVF        FARG_LCD_DrawRect_y+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVF        FARG_LCD_DrawRect_h+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        FARG_LCD_DrawRect_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,571 :: 		}
L_end_LCD_DrawRect:
	RETURN      0
; end of _LCD_DrawRect

_LCD_DrawRoundRect:

;nokia5110.h,574 :: 		void LCD_DrawRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r, bool color)
;nokia5110.h,576 :: 		int16_t max_radius = ((w < h) ? w : h) / 2; // 1/2 minor axis
	MOVF        FARG_LCD_DrawRoundRect_h+0, 0 
	SUBWF       FARG_LCD_DrawRoundRect_w+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawRoundRect52
	MOVF        FARG_LCD_DrawRoundRect_w+0, 0 
	MOVWF       ?FLOC___LCD_DrawRoundRectT167+0 
	GOTO        L_LCD_DrawRoundRect53
L_LCD_DrawRoundRect52:
	MOVF        FARG_LCD_DrawRoundRect_h+0, 0 
	MOVWF       ?FLOC___LCD_DrawRoundRectT167+0 
L_LCD_DrawRoundRect53:
	MOVLW       2
	MOVWF       R4 
	MOVF        ?FLOC___LCD_DrawRoundRectT167+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_DrawRoundRect_max_radius_L0+0 
	MOVLW       0
	MOVWF       LCD_DrawRoundRect_max_radius_L0+1 
;nokia5110.h,577 :: 		if(r > max_radius) r = max_radius;
	MOVLW       128
	XORWF       LCD_DrawRoundRect_max_radius_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_DrawRoundRect221
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	SUBWF       LCD_DrawRoundRect_max_radius_L0+0, 0 
L__LCD_DrawRoundRect221:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_DrawRoundRect54
	MOVF        LCD_DrawRoundRect_max_radius_L0+0, 0 
	MOVWF       FARG_LCD_DrawRoundRect_r+0 
L_LCD_DrawRoundRect54:
;nokia5110.h,579 :: 		LCD_DrawHLine(x + r, y, w - 2 * r, color); // Top
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	MOVLW       2
	MULWF       FARG_LCD_DrawRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_DrawRoundRect_w+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,580 :: 		LCD_DrawHLine(x + r, y + h - 1, w - 2 * r, color); // Bottom
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        FARG_LCD_DrawRoundRect_h+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	DECF        FARG_LCD_DrawHLine_y+0, 1 
	MOVLW       2
	MULWF       FARG_LCD_DrawRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_DrawRoundRect_w+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,581 :: 		LCD_DrawVLine(x, y + r, h - 2 * r, color); // Left
	MOVF        FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       FARG_LCD_DrawRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_DrawRoundRect_h+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,582 :: 		LCD_DrawVLine(x + w - 1, y + r, h - 2 * r, color); // Right
	MOVF        FARG_LCD_DrawRoundRect_w+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	DECF        FARG_LCD_DrawVLine_x+0, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       2
	MULWF       FARG_LCD_DrawRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_DrawRoundRect_h+0, 0 
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
;nokia5110.h,584 :: 		LCD_DrawCircleHelper(x + r, y + r, r, 1, color);
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_x0+0 
	CLRF        FARG_LCD_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_y0+0 
	CLRF        FARG_LCD_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawCircleHelper_r+1 
	MOVLW       1
	MOVWF       FARG_LCD_DrawCircleHelper_cornername+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_color+0 
	CALL        _LCD_DrawCircleHelper+0, 0
;nokia5110.h,585 :: 		LCD_DrawCircleHelper(x + w - r - 1, y + r, r, 2, color);
	MOVF        FARG_LCD_DrawRoundRect_w+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_x0+0 
	CLRF        FARG_LCD_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_y0+0 
	CLRF        FARG_LCD_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawCircleHelper_r+1 
	MOVLW       2
	MOVWF       FARG_LCD_DrawCircleHelper_cornername+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_color+0 
	CALL        _LCD_DrawCircleHelper+0, 0
;nokia5110.h,586 :: 		LCD_DrawCircleHelper(x + w - r - 1, y + h - r - 1, r, 4, color);
	MOVF        FARG_LCD_DrawRoundRect_w+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_x0+0 
	CLRF        FARG_LCD_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_DrawCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_h+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_y0+0 
	CLRF        FARG_LCD_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawCircleHelper_r+1 
	MOVLW       4
	MOVWF       FARG_LCD_DrawCircleHelper_cornername+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_color+0 
	CALL        _LCD_DrawCircleHelper+0, 0
;nokia5110.h,587 :: 		LCD_DrawCircleHelper(x + r, y + h - r - 1, r, 8, color);
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_x+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_x0+0 
	CLRF        FARG_LCD_DrawCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_h+0, 0 
	ADDWF       FARG_LCD_DrawRoundRect_y+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_y0+0 
	CLRF        FARG_LCD_DrawCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_DrawCircleHelper_y0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_DrawCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_DrawRoundRect_r+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawCircleHelper_r+1 
	MOVLW       8
	MOVWF       FARG_LCD_DrawCircleHelper_cornername+0 
	MOVF        FARG_LCD_DrawRoundRect_color+0, 0 
	MOVWF       FARG_LCD_DrawCircleHelper_color+0 
	CALL        _LCD_DrawCircleHelper+0, 0
;nokia5110.h,588 :: 		}
L_end_LCD_DrawRoundRect:
	RETURN      0
; end of _LCD_DrawRoundRect

_LCD_FillRoundRect:

;nokia5110.h,591 :: 		void LCD_FillRoundRect(uint8_t x, uint8_t y, uint8_t w, uint8_t h, uint8_t r, bool color)
;nokia5110.h,593 :: 		int16_t max_radius = ((w < h) ? w : h) / 2; // 1/2 minor axis
	MOVF        FARG_LCD_FillRoundRect_h+0, 0 
	SUBWF       FARG_LCD_FillRoundRect_w+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillRoundRect55
	MOVF        FARG_LCD_FillRoundRect_w+0, 0 
	MOVWF       ?FLOC___LCD_FillRoundRectT203+0 
	GOTO        L_LCD_FillRoundRect56
L_LCD_FillRoundRect55:
	MOVF        FARG_LCD_FillRoundRect_h+0, 0 
	MOVWF       ?FLOC___LCD_FillRoundRectT203+0 
L_LCD_FillRoundRect56:
	MOVLW       2
	MOVWF       R4 
	MOVF        ?FLOC___LCD_FillRoundRectT203+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_FillRoundRect_max_radius_L0+0 
	MOVLW       0
	MOVWF       LCD_FillRoundRect_max_radius_L0+1 
;nokia5110.h,594 :: 		if(r > max_radius) r = max_radius;
	MOVLW       128
	XORWF       LCD_FillRoundRect_max_radius_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillRoundRect223
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	SUBWF       LCD_FillRoundRect_max_radius_L0+0, 0 
L__LCD_FillRoundRect223:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillRoundRect57
	MOVF        LCD_FillRoundRect_max_radius_L0+0, 0 
	MOVWF       FARG_LCD_FillRoundRect_r+0 
L_LCD_FillRoundRect57:
;nokia5110.h,596 :: 		LCD_FillRect(x + r, y, w - 2 * r, h, color);
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	ADDWF       FARG_LCD_FillRoundRect_x+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        FARG_LCD_FillRoundRect_y+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVLW       2
	MULWF       FARG_LCD_FillRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_FillRoundRect_w+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVF        FARG_LCD_FillRoundRect_h+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        FARG_LCD_FillRoundRect_color+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
;nokia5110.h,598 :: 		LCD_FillCircleHelper(x + w - r - 1, y + r, r, 1, h - 2 * r - 1, color);
	MOVF        FARG_LCD_FillRoundRect_w+0, 0 
	ADDWF       FARG_LCD_FillRoundRect_x+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_x0+0 
	CLRF        FARG_LCD_FillCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_FillCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	SUBWF       FARG_LCD_FillCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_FillCircleHelper_x0+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_FillCircleHelper_x0+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_FillCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	ADDWF       FARG_LCD_FillRoundRect_y+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_y0+0 
	CLRF        FARG_LCD_FillCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_FillCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_LCD_FillCircleHelper_r+1 
	MOVLW       1
	MOVWF       FARG_LCD_FillCircleHelper_cornername+0 
	MOVLW       2
	MULWF       FARG_LCD_FillRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_FillRoundRect_h+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_delta+0 
	MOVF        R1, 0 
	MOVWF       FARG_LCD_FillCircleHelper_delta+1 
	MOVLW       0
	SUBFWB      FARG_LCD_FillCircleHelper_delta+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_FillCircleHelper_delta+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_FillCircleHelper_delta+1, 1 
	MOVF        FARG_LCD_FillRoundRect_color+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_color+0 
	CALL        _LCD_FillCircleHelper+0, 0
;nokia5110.h,599 :: 		LCD_FillCircleHelper(x + r        , y + r, r, 2, h - 2 * r - 1, color);
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	ADDWF       FARG_LCD_FillRoundRect_x+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_x0+0 
	CLRF        FARG_LCD_FillCircleHelper_x0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_FillCircleHelper_x0+1, 1 
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	ADDWF       FARG_LCD_FillRoundRect_y+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_y0+0 
	CLRF        FARG_LCD_FillCircleHelper_y0+1 
	MOVLW       0
	ADDWFC      FARG_LCD_FillCircleHelper_y0+1, 1 
	MOVF        FARG_LCD_FillRoundRect_r+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_r+0 
	MOVLW       0
	MOVWF       FARG_LCD_FillCircleHelper_r+1 
	MOVLW       2
	MOVWF       FARG_LCD_FillCircleHelper_cornername+0 
	MOVLW       2
	MULWF       FARG_LCD_FillRoundRect_r+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	SUBWF       FARG_LCD_FillRoundRect_h+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_delta+0 
	MOVF        R1, 0 
	MOVWF       FARG_LCD_FillCircleHelper_delta+1 
	MOVLW       0
	SUBFWB      FARG_LCD_FillCircleHelper_delta+1, 1 
	MOVLW       1
	SUBWF       FARG_LCD_FillCircleHelper_delta+0, 1 
	MOVLW       0
	SUBWFB      FARG_LCD_FillCircleHelper_delta+1, 1 
	MOVF        FARG_LCD_FillRoundRect_color+0, 0 
	MOVWF       FARG_LCD_FillCircleHelper_color+0 
	CALL        _LCD_FillCircleHelper+0, 0
;nokia5110.h,600 :: 		}
L_end_LCD_FillRoundRect:
	RETURN      0
; end of _LCD_FillRoundRect

_LCD_DrawTriangle:

;nokia5110.h,603 :: 		void LCD_DrawTriangle(uint8_t x0, uint8_t y0, uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2, bool color)
;nokia5110.h,605 :: 		LCD_DrawLine(x0, y0, x1, y1, color);
	MOVF        FARG_LCD_DrawTriangle_x0+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        FARG_LCD_DrawTriangle_y0+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y0+1 
	MOVF        FARG_LCD_DrawTriangle_x1+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x1+1 
	MOVF        FARG_LCD_DrawTriangle_y1+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y1+1 
	MOVF        FARG_LCD_DrawTriangle_color+0, 0 
	MOVWF       FARG_LCD_DrawLine_color+0 
	CALL        _LCD_DrawLine+0, 0
;nokia5110.h,606 :: 		LCD_DrawLine(x1, y1, x2, y2, color);
	MOVF        FARG_LCD_DrawTriangle_x1+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        FARG_LCD_DrawTriangle_y1+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y0+1 
	MOVF        FARG_LCD_DrawTriangle_x2+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x1+1 
	MOVF        FARG_LCD_DrawTriangle_y2+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y1+1 
	MOVF        FARG_LCD_DrawTriangle_color+0, 0 
	MOVWF       FARG_LCD_DrawLine_color+0 
	CALL        _LCD_DrawLine+0, 0
;nokia5110.h,607 :: 		LCD_DrawLine(x2, y2, x0, y0, color);
	MOVF        FARG_LCD_DrawTriangle_x2+0, 0 
	MOVWF       FARG_LCD_DrawLine_x0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x0+1 
	MOVF        FARG_LCD_DrawTriangle_y2+0, 0 
	MOVWF       FARG_LCD_DrawLine_y0+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y0+1 
	MOVF        FARG_LCD_DrawTriangle_x0+0, 0 
	MOVWF       FARG_LCD_DrawLine_x1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_x1+1 
	MOVF        FARG_LCD_DrawTriangle_y0+0, 0 
	MOVWF       FARG_LCD_DrawLine_y1+0 
	MOVLW       0
	MOVWF       FARG_LCD_DrawLine_y1+1 
	MOVF        FARG_LCD_DrawTriangle_color+0, 0 
	MOVWF       FARG_LCD_DrawLine_color+0 
	CALL        _LCD_DrawLine+0, 0
;nokia5110.h,608 :: 		}
L_end_LCD_DrawTriangle:
	RETURN      0
; end of _LCD_DrawTriangle

_LCD_FillTriangle:

;nokia5110.h,610 :: 		void LCD_FillTriangle(int16_t x0, int16_t y0, int16_t x1, int16_t y1, int16_t x2, int16_t y2, bool color)
;nokia5110.h,614 :: 		int32_t  sa = 0, sb = 0;
	CLRF        LCD_FillTriangle_sa_L0+0 
	CLRF        LCD_FillTriangle_sa_L0+1 
	CLRF        LCD_FillTriangle_sa_L0+2 
	CLRF        LCD_FillTriangle_sa_L0+3 
	CLRF        LCD_FillTriangle_sb_L0+0 
	CLRF        LCD_FillTriangle_sb_L0+1 
	CLRF        LCD_FillTriangle_sb_L0+2 
	CLRF        LCD_FillTriangle_sb_L0+3 
;nokia5110.h,616 :: 		if (y0 > y1) {
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle226
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y1+0, 0 
L__LCD_FillTriangle226:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle58
;nokia5110.h,617 :: 		LCD_swap(y0, y1); LCD_swap(x0, x1);
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	MOVWF       LCD_FillTriangle_t_L2+0 
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	MOVWF       LCD_FillTriangle_t_L2+1 
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	MOVWF       FARG_LCD_FillTriangle_y0+0 
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       FARG_LCD_FillTriangle_y0+1 
	MOVF        LCD_FillTriangle_t_L2+0, 0 
	MOVWF       FARG_LCD_FillTriangle_y1+0 
	MOVF        LCD_FillTriangle_t_L2+1, 0 
	MOVWF       FARG_LCD_FillTriangle_y1+1 
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2+1 
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	MOVWF       FARG_LCD_FillTriangle_x0+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       FARG_LCD_FillTriangle_x0+1 
	MOVF        LCD_FillTriangle_t_L2_L2+0, 0 
	MOVWF       FARG_LCD_FillTriangle_x1+0 
	MOVF        LCD_FillTriangle_t_L2_L2+1, 0 
	MOVWF       FARG_LCD_FillTriangle_x1+1 
;nokia5110.h,618 :: 		}
L_LCD_FillTriangle58:
;nokia5110.h,619 :: 		if (y1 > y2) {
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle227
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y2+0, 0 
L__LCD_FillTriangle227:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle59
;nokia5110.h,620 :: 		LCD_swap(y2, y1); LCD_swap(x2, x1);
	MOVF        FARG_LCD_FillTriangle_y2+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2+0 
	MOVF        FARG_LCD_FillTriangle_y2+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2+1 
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	MOVWF       FARG_LCD_FillTriangle_y2+0 
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       FARG_LCD_FillTriangle_y2+1 
	MOVF        LCD_FillTriangle_t_L2_L2_L2+0, 0 
	MOVWF       FARG_LCD_FillTriangle_y1+0 
	MOVF        LCD_FillTriangle_t_L2_L2_L2+1, 0 
	MOVWF       FARG_LCD_FillTriangle_y1+1 
	MOVF        FARG_LCD_FillTriangle_x2+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2+0 
	MOVF        FARG_LCD_FillTriangle_x2+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2+1 
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	MOVWF       FARG_LCD_FillTriangle_x2+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       FARG_LCD_FillTriangle_x2+1 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_LCD_FillTriangle_x1+0 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_LCD_FillTriangle_x1+1 
;nokia5110.h,621 :: 		}
L_LCD_FillTriangle59:
;nokia5110.h,622 :: 		if (y0 > y1) {
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle228
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y1+0, 0 
L__LCD_FillTriangle228:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle60
;nokia5110.h,623 :: 		LCD_swap(y0, y1); LCD_swap(x0, x1);
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2+0 
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2+1 
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	MOVWF       FARG_LCD_FillTriangle_y0+0 
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       FARG_LCD_FillTriangle_y0+1 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_LCD_FillTriangle_y1+0 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_LCD_FillTriangle_y1+1 
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2+1 
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	MOVWF       FARG_LCD_FillTriangle_x0+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       FARG_LCD_FillTriangle_x0+1 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_LCD_FillTriangle_x1+0 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2+1, 0 
	MOVWF       FARG_LCD_FillTriangle_x1+1 
;nokia5110.h,624 :: 		}
L_LCD_FillTriangle60:
;nokia5110.h,626 :: 		if(y0 == y2) { // Handle awkward all-on-same-line case as its own thing
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	XORWF       FARG_LCD_FillTriangle_y2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle229
	MOVF        FARG_LCD_FillTriangle_y2+0, 0 
	XORWF       FARG_LCD_FillTriangle_y0+0, 0 
L__LCD_FillTriangle229:
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_FillTriangle61
;nokia5110.h,627 :: 		a = b = x0;
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
	MOVF        LCD_FillTriangle_b_L0+0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        LCD_FillTriangle_b_L0+1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
;nokia5110.h,628 :: 		if(x1 < a)      a = x1;
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillTriangle_a_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle230
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_x1+0, 0 
L__LCD_FillTriangle230:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle62
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
	GOTO        L_LCD_FillTriangle63
L_LCD_FillTriangle62:
;nokia5110.h,629 :: 		else if(x1 > b) b = x1;
	MOVLW       128
	XORWF       LCD_FillTriangle_b_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_x1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle231
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
L__LCD_FillTriangle231:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle64
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
L_LCD_FillTriangle64:
L_LCD_FillTriangle63:
;nokia5110.h,630 :: 		if(x2 < a)      a = x2;
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_x2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillTriangle_a_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle232
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_x2+0, 0 
L__LCD_FillTriangle232:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle65
	MOVF        FARG_LCD_FillTriangle_x2+0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        FARG_LCD_FillTriangle_x2+1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
	GOTO        L_LCD_FillTriangle66
L_LCD_FillTriangle65:
;nokia5110.h,631 :: 		else if(x2 > b) b = x2;
	MOVLW       128
	XORWF       LCD_FillTriangle_b_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_x2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle233
	MOVF        FARG_LCD_FillTriangle_x2+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
L__LCD_FillTriangle233:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle67
	MOVF        FARG_LCD_FillTriangle_x2+0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        FARG_LCD_FillTriangle_x2+1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
L_LCD_FillTriangle67:
L_LCD_FillTriangle66:
;nokia5110.h,632 :: 		LCD_DrawHLine(a, y0, b - a + 1, color);
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	INCF        FARG_LCD_DrawHLine_w+0, 1 
	MOVF        FARG_LCD_FillTriangle_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,633 :: 		return;
	GOTO        L_end_LCD_FillTriangle
;nokia5110.h,634 :: 		}
L_LCD_FillTriangle61:
;nokia5110.h,636 :: 		dx01 = x1 - x0,
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_x1+0, 0 
	MOVWF       LCD_FillTriangle_dx01_L0+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	SUBWFB      FARG_LCD_FillTriangle_x1+1, 0 
	MOVWF       LCD_FillTriangle_dx01_L0+1 
;nokia5110.h,637 :: 		dy01 = y1 - y0,
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y1+0, 0 
	MOVWF       LCD_FillTriangle_dy01_L0+0 
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	SUBWFB      FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       LCD_FillTriangle_dy01_L0+1 
;nokia5110.h,638 :: 		dx02 = x2 - x0,
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_x2+0, 0 
	MOVWF       LCD_FillTriangle_dx02_L0+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	SUBWFB      FARG_LCD_FillTriangle_x2+1, 0 
	MOVWF       LCD_FillTriangle_dx02_L0+1 
;nokia5110.h,639 :: 		dy02 = y2 - y0,
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y2+0, 0 
	MOVWF       LCD_FillTriangle_dy02_L0+0 
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	SUBWFB      FARG_LCD_FillTriangle_y2+1, 0 
	MOVWF       LCD_FillTriangle_dy02_L0+1 
;nokia5110.h,640 :: 		dx12 = x2 - x1,
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	SUBWF       FARG_LCD_FillTriangle_x2+0, 0 
	MOVWF       LCD_FillTriangle_dx12_L0+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	SUBWFB      FARG_LCD_FillTriangle_x2+1, 0 
	MOVWF       LCD_FillTriangle_dx12_L0+1 
;nokia5110.h,641 :: 		dy12 = y2 - y1;
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y2+0, 0 
	MOVWF       LCD_FillTriangle_dy12_L0+0 
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	SUBWFB      FARG_LCD_FillTriangle_y2+1, 0 
	MOVWF       LCD_FillTriangle_dy12_L0+1 
;nokia5110.h,643 :: 		if(y1 == y2) last = y1;
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	XORWF       FARG_LCD_FillTriangle_y2+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle234
	MOVF        FARG_LCD_FillTriangle_y2+0, 0 
	XORWF       FARG_LCD_FillTriangle_y1+0, 0 
L__LCD_FillTriangle234:
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_FillTriangle68
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	MOVWF       LCD_FillTriangle_last_L0+0 
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       LCD_FillTriangle_last_L0+1 
	GOTO        L_LCD_FillTriangle69
L_LCD_FillTriangle68:
;nokia5110.h,644 :: 		else         last = y1 - 1;
	MOVLW       1
	SUBWF       FARG_LCD_FillTriangle_y1+0, 0 
	MOVWF       LCD_FillTriangle_last_L0+0 
	MOVLW       0
	SUBWFB      FARG_LCD_FillTriangle_y1+1, 0 
	MOVWF       LCD_FillTriangle_last_L0+1 
L_LCD_FillTriangle69:
;nokia5110.h,646 :: 		for(y = y0; y <= last; y++) {
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	MOVWF       LCD_FillTriangle_y_L0+0 
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	MOVWF       LCD_FillTriangle_y_L0+1 
L_LCD_FillTriangle70:
	MOVLW       128
	XORWF       LCD_FillTriangle_last_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillTriangle_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle235
	MOVF        LCD_FillTriangle_y_L0+0, 0 
	SUBWF       LCD_FillTriangle_last_L0+0, 0 
L__LCD_FillTriangle235:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle71
;nokia5110.h,647 :: 		a   = x0 + sa / dy01;
	MOVF        LCD_FillTriangle_dy01_L0+0, 0 
	MOVWF       R4 
	MOVF        LCD_FillTriangle_dy01_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dy01_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        LCD_FillTriangle_sa_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_FillTriangle_sa_L0+1, 0 
	MOVWF       R1 
	MOVF        LCD_FillTriangle_sa_L0+2, 0 
	MOVWF       R2 
	MOVF        LCD_FillTriangle_sa_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	ADDWF       R0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
;nokia5110.h,648 :: 		b   = x0 + sb / dy02;
	MOVF        LCD_FillTriangle_dy02_L0+0, 0 
	MOVWF       R4 
	MOVF        LCD_FillTriangle_dy02_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dy02_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        LCD_FillTriangle_sb_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_FillTriangle_sb_L0+1, 0 
	MOVWF       R1 
	MOVF        LCD_FillTriangle_sb_L0+2, 0 
	MOVWF       R2 
	MOVF        LCD_FillTriangle_sb_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	ADDWF       R0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
;nokia5110.h,649 :: 		sa += dx01;
	MOVF        LCD_FillTriangle_dx01_L0+0, 0 
	ADDWF       LCD_FillTriangle_sa_L0+0, 1 
	MOVF        LCD_FillTriangle_dx01_L0+1, 0 
	ADDWFC      LCD_FillTriangle_sa_L0+1, 1 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dx01_L0+1, 7 
	MOVLW       255
	ADDWFC      LCD_FillTriangle_sa_L0+2, 1 
	ADDWFC      LCD_FillTriangle_sa_L0+3, 1 
;nokia5110.h,650 :: 		sb += dx02;
	MOVF        LCD_FillTriangle_dx02_L0+0, 0 
	ADDWF       LCD_FillTriangle_sb_L0+0, 1 
	MOVF        LCD_FillTriangle_dx02_L0+1, 0 
	ADDWFC      LCD_FillTriangle_sb_L0+1, 1 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dx02_L0+1, 7 
	MOVLW       255
	ADDWFC      LCD_FillTriangle_sb_L0+2, 1 
	ADDWFC      LCD_FillTriangle_sb_L0+3, 1 
;nokia5110.h,652 :: 		if(a > b) LCD_swap(a, b);
	MOVLW       128
	XORWF       LCD_FillTriangle_b_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillTriangle_a_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle236
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
L__LCD_FillTriangle236:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle73
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+0 
	MOVF        LCD_FillTriangle_a_L0+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+1 
	MOVF        LCD_FillTriangle_b_L0+0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        LCD_FillTriangle_b_L0+1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2+1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
L_LCD_FillTriangle73:
;nokia5110.h,653 :: 		LCD_DrawHLine(a, y, b - a + 1, color);
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        LCD_FillTriangle_y_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	INCF        FARG_LCD_DrawHLine_w+0, 1 
	MOVF        FARG_LCD_FillTriangle_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,646 :: 		for(y = y0; y <= last; y++) {
	INFSNZ      LCD_FillTriangle_y_L0+0, 1 
	INCF        LCD_FillTriangle_y_L0+1, 1 
;nokia5110.h,654 :: 		}
	GOTO        L_LCD_FillTriangle70
L_LCD_FillTriangle71:
;nokia5110.h,656 :: 		sa = dx12 * (y - y1);
	MOVF        FARG_LCD_FillTriangle_y1+0, 0 
	SUBWF       LCD_FillTriangle_y_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_LCD_FillTriangle_y1+1, 0 
	SUBWFB      LCD_FillTriangle_y_L0+1, 0 
	MOVWF       R1 
	MOVF        LCD_FillTriangle_dx12_L0+0, 0 
	MOVWF       R4 
	MOVF        LCD_FillTriangle_dx12_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_FillTriangle_sa_L0+0 
	MOVF        R1, 0 
	MOVWF       LCD_FillTriangle_sa_L0+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       LCD_FillTriangle_sa_L0+2 
	MOVWF       LCD_FillTriangle_sa_L0+3 
;nokia5110.h,657 :: 		sb = dx02 * (y - y0);
	MOVF        FARG_LCD_FillTriangle_y0+0, 0 
	SUBWF       LCD_FillTriangle_y_L0+0, 0 
	MOVWF       R0 
	MOVF        FARG_LCD_FillTriangle_y0+1, 0 
	SUBWFB      LCD_FillTriangle_y_L0+1, 0 
	MOVWF       R1 
	MOVF        LCD_FillTriangle_dx02_L0+0, 0 
	MOVWF       R4 
	MOVF        LCD_FillTriangle_dx02_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       LCD_FillTriangle_sb_L0+0 
	MOVF        R1, 0 
	MOVWF       LCD_FillTriangle_sb_L0+1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       LCD_FillTriangle_sb_L0+2 
	MOVWF       LCD_FillTriangle_sb_L0+3 
;nokia5110.h,658 :: 		for(; y <= y2; y++) {
L_LCD_FillTriangle74:
	MOVLW       128
	XORWF       FARG_LCD_FillTriangle_y2+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillTriangle_y_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle237
	MOVF        LCD_FillTriangle_y_L0+0, 0 
	SUBWF       FARG_LCD_FillTriangle_y2+0, 0 
L__LCD_FillTriangle237:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle75
;nokia5110.h,659 :: 		a   = x1 + sa / dy12;
	MOVF        LCD_FillTriangle_dy12_L0+0, 0 
	MOVWF       R4 
	MOVF        LCD_FillTriangle_dy12_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dy12_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        LCD_FillTriangle_sa_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_FillTriangle_sa_L0+1, 0 
	MOVWF       R1 
	MOVF        LCD_FillTriangle_sa_L0+2, 0 
	MOVWF       R2 
	MOVF        LCD_FillTriangle_sa_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_LCD_FillTriangle_x1+0, 0 
	ADDWF       R0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        FARG_LCD_FillTriangle_x1+1, 0 
	ADDWFC      R1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
;nokia5110.h,660 :: 		b   = x0 + sb / dy02;
	MOVF        LCD_FillTriangle_dy02_L0+0, 0 
	MOVWF       R4 
	MOVF        LCD_FillTriangle_dy02_L0+1, 0 
	MOVWF       R5 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dy02_L0+1, 7 
	MOVLW       255
	MOVWF       R6 
	MOVWF       R7 
	MOVF        LCD_FillTriangle_sb_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_FillTriangle_sb_L0+1, 0 
	MOVWF       R1 
	MOVF        LCD_FillTriangle_sb_L0+2, 0 
	MOVWF       R2 
	MOVF        LCD_FillTriangle_sb_L0+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_S+0, 0
	MOVF        FARG_LCD_FillTriangle_x0+0, 0 
	ADDWF       R0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        FARG_LCD_FillTriangle_x0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
;nokia5110.h,661 :: 		sa += dx12;
	MOVF        LCD_FillTriangle_dx12_L0+0, 0 
	ADDWF       LCD_FillTriangle_sa_L0+0, 1 
	MOVF        LCD_FillTriangle_dx12_L0+1, 0 
	ADDWFC      LCD_FillTriangle_sa_L0+1, 1 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dx12_L0+1, 7 
	MOVLW       255
	ADDWFC      LCD_FillTriangle_sa_L0+2, 1 
	ADDWFC      LCD_FillTriangle_sa_L0+3, 1 
;nokia5110.h,662 :: 		sb += dx02;
	MOVF        LCD_FillTriangle_dx02_L0+0, 0 
	ADDWF       LCD_FillTriangle_sb_L0+0, 1 
	MOVF        LCD_FillTriangle_dx02_L0+1, 0 
	ADDWFC      LCD_FillTriangle_sb_L0+1, 1 
	MOVLW       0
	BTFSC       LCD_FillTriangle_dx02_L0+1, 7 
	MOVLW       255
	ADDWFC      LCD_FillTriangle_sb_L0+2, 1 
	ADDWFC      LCD_FillTriangle_sb_L0+3, 1 
;nokia5110.h,664 :: 		if(a > b) LCD_swap(a, b);
	MOVLW       128
	XORWF       LCD_FillTriangle_b_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       LCD_FillTriangle_a_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_FillTriangle238
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
L__LCD_FillTriangle238:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_FillTriangle77
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+0 
	MOVF        LCD_FillTriangle_a_L0+1, 0 
	MOVWF       LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+1 
	MOVF        LCD_FillTriangle_b_L0+0, 0 
	MOVWF       LCD_FillTriangle_a_L0+0 
	MOVF        LCD_FillTriangle_b_L0+1, 0 
	MOVWF       LCD_FillTriangle_a_L0+1 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       LCD_FillTriangle_b_L0+0 
	MOVF        LCD_FillTriangle_t_L2_L2_L2_L2_L2_L2_L2_L2+1, 0 
	MOVWF       LCD_FillTriangle_b_L0+1 
L_LCD_FillTriangle77:
;nokia5110.h,665 :: 		LCD_DrawHLine(a, y, b - a + 1, color);
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_x+0 
	MOVF        LCD_FillTriangle_y_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_y+0 
	MOVF        LCD_FillTriangle_a_L0+0, 0 
	SUBWF       LCD_FillTriangle_b_L0+0, 0 
	MOVWF       FARG_LCD_DrawHLine_w+0 
	INCF        FARG_LCD_DrawHLine_w+0, 1 
	MOVF        FARG_LCD_FillTriangle_color+0, 0 
	MOVWF       FARG_LCD_DrawHLine_color+0 
	CALL        _LCD_DrawHLine+0, 0
;nokia5110.h,658 :: 		for(; y <= y2; y++) {
	INFSNZ      LCD_FillTriangle_y_L0+0, 1 
	INCF        LCD_FillTriangle_y_L0+1, 1 
;nokia5110.h,666 :: 		}
	GOTO        L_LCD_FillTriangle74
L_LCD_FillTriangle75:
;nokia5110.h,667 :: 		}
L_end_LCD_FillTriangle:
	RETURN      0
; end of _LCD_FillTriangle

_LCD_Clear:

;nokia5110.h,669 :: 		void LCD_Clear()
;nokia5110.h,672 :: 		for (i = 0; i < 504; i++)  // 504 = LCDWIDTH*LCDHEIGHT / 8
	CLRF        LCD_Clear_i_L0+0 
	CLRF        LCD_Clear_i_L0+1 
L_LCD_Clear78:
	MOVLW       1
	SUBWF       LCD_Clear_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_Clear240
	MOVLW       248
	SUBWF       LCD_Clear_i_L0+0, 0 
L__LCD_Clear240:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Clear79
;nokia5110.h,673 :: 		lcd_buffer[i] = 0;
	MOVLW       _lcd_buffer+0
	ADDWF       LCD_Clear_i_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_lcd_buffer+0)
	ADDWFC      LCD_Clear_i_L0+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
;nokia5110.h,672 :: 		for (i = 0; i < 504; i++)  // 504 = LCDWIDTH*LCDHEIGHT / 8
	INFSNZ      LCD_Clear_i_L0+0, 1 
	INCF        LCD_Clear_i_L0+1, 1 
;nokia5110.h,673 :: 		lcd_buffer[i] = 0;
	GOTO        L_LCD_Clear78
L_LCD_Clear79:
;nokia5110.h,674 :: 		}
L_end_LCD_Clear:
	RETURN      0
; end of _LCD_Clear

_LCD_Fill:

;nokia5110.h,676 :: 		void LCD_Fill()
;nokia5110.h,679 :: 		for (i = 0; i < 504; i++)  // 504 = LCDWIDTH*LCDHEIGHT / 8
	CLRF        LCD_Fill_i_L0+0 
	CLRF        LCD_Fill_i_L0+1 
L_LCD_Fill81:
	MOVLW       1
	SUBWF       LCD_Fill_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_Fill242
	MOVLW       248
	SUBWF       LCD_Fill_i_L0+0, 0 
L__LCD_Fill242:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_Fill82
;nokia5110.h,680 :: 		lcd_buffer[i] = 0xFF;
	MOVLW       _lcd_buffer+0
	ADDWF       LCD_Fill_i_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_lcd_buffer+0)
	ADDWFC      LCD_Fill_i_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       255
	MOVWF       POSTINC1+0 
;nokia5110.h,679 :: 		for (i = 0; i < 504; i++)  // 504 = LCDWIDTH*LCDHEIGHT / 8
	INFSNZ      LCD_Fill_i_L0+0, 1 
	INCF        LCD_Fill_i_L0+1, 1 
;nokia5110.h,680 :: 		lcd_buffer[i] = 0xFF;
	GOTO        L_LCD_Fill81
L_LCD_Fill82:
;nokia5110.h,681 :: 		}
L_end_LCD_Fill:
	RETURN      0
; end of _LCD_Fill

_LCD_TextSize:

;nokia5110.h,683 :: 		void LCD_TextSize(uint8_t t_size)
;nokia5110.h,685 :: 		if(t_size < 1)
	MOVLW       1
	SUBWF       FARG_LCD_TextSize_t_size+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_TextSize84
;nokia5110.h,686 :: 		return;
	GOTO        L_end_LCD_TextSize
L_LCD_TextSize84:
;nokia5110.h,687 :: 		text_size = t_size;
	MOVF        FARG_LCD_TextSize_t_size+0, 0 
	MOVWF       _text_size+0 
;nokia5110.h,688 :: 		}
L_end_LCD_TextSize:
	RETURN      0
; end of _LCD_TextSize

_LCD_GotoXY:

;nokia5110.h,690 :: 		void LCD_GotoXY(uint8_t x, uint8_t y)
;nokia5110.h,692 :: 		if((x >= LCDWIDTH) || (y >= LCDHEIGHT))
	MOVLW       84
	SUBWF       FARG_LCD_GotoXY_x+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__LCD_GotoXY180
	MOVLW       48
	SUBWF       FARG_LCD_GotoXY_y+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L__LCD_GotoXY180
	GOTO        L_LCD_GotoXY87
L__LCD_GotoXY180:
;nokia5110.h,693 :: 		return;
	GOTO        L_end_LCD_GotoXY
L_LCD_GotoXY87:
;nokia5110.h,694 :: 		x_pos = x;
	MOVF        FARG_LCD_GotoXY_x+0, 0 
	MOVWF       _x_pos+0 
;nokia5110.h,695 :: 		y_pos = y;
	MOVF        FARG_LCD_GotoXY_y+0, 0 
	MOVWF       _y_pos+0 
;nokia5110.h,696 :: 		}
L_end_LCD_GotoXY:
	RETURN      0
; end of _LCD_GotoXY

_LCD_GetX:

;nokia5110.h,698 :: 		uint8_t LCD_GetX()
;nokia5110.h,700 :: 		return x_pos;
	MOVF        _x_pos+0, 0 
	MOVWF       R0 
;nokia5110.h,701 :: 		}
L_end_LCD_GetX:
	RETURN      0
; end of _LCD_GetX

_LCD_GetY:

;nokia5110.h,703 :: 		uint8_t LCD_GetY()
;nokia5110.h,705 :: 		return y_pos;
	MOVF        _y_pos+0, 0 
	MOVWF       R0 
;nokia5110.h,706 :: 		}
L_end_LCD_GetY:
	RETURN      0
; end of _LCD_GetY

_LCD_TextWrap:

;nokia5110.h,708 :: 		void LCD_TextWrap(bool w)
;nokia5110.h,710 :: 		wrap = w;
	MOVF        FARG_LCD_TextWrap_w+0, 0 
	MOVWF       _wrap+0 
;nokia5110.h,711 :: 		}
L_end_LCD_TextWrap:
	RETURN      0
; end of _LCD_TextWrap

_LCD_TextColor:

;nokia5110.h,713 :: 		void LCD_TextColor(bool t_color, bool t_bg)
;nokia5110.h,715 :: 		text_color = t_color;
	MOVF        FARG_LCD_TextColor_t_color+0, 0 
	MOVWF       _text_color+0 
;nokia5110.h,716 :: 		text_bg = t_bg;
	MOVF        FARG_LCD_TextColor_t_bg+0, 0 
	MOVWF       _text_bg+0 
;nokia5110.h,717 :: 		}
L_end_LCD_TextColor:
	RETURN      0
; end of _LCD_TextColor

_LCD_SetRotation:

;nokia5110.h,721 :: 		void LCD_SetRotation(uint8_t rot)
;nokia5110.h,723 :: 		rotation = (rot & 3);
	MOVLW       3
	ANDWF       FARG_LCD_SetRotation_rot+0, 0 
	MOVWF       _rotation+0 
;nokia5110.h,724 :: 		switch(rotation) {
	GOTO        L_LCD_SetRotation88
;nokia5110.h,725 :: 		case 0:
L_LCD_SetRotation90:
;nokia5110.h,726 :: 		case 2:
L_LCD_SetRotation91:
;nokia5110.h,727 :: 		_width  = LCDWIDTH;
	MOVLW       84
	MOVWF       __width+0 
;nokia5110.h,728 :: 		_height = LCDHEIGHT;
	MOVLW       48
	MOVWF       __height+0 
;nokia5110.h,729 :: 		break;
	GOTO        L_LCD_SetRotation89
;nokia5110.h,730 :: 		case 1:
L_LCD_SetRotation92:
;nokia5110.h,731 :: 		case 3:
L_LCD_SetRotation93:
;nokia5110.h,732 :: 		_width  = LCDHEIGHT;
	MOVLW       48
	MOVWF       __width+0 
;nokia5110.h,733 :: 		_height = LCDWIDTH;
	MOVLW       84
	MOVWF       __height+0 
;nokia5110.h,734 :: 		break;
	GOTO        L_LCD_SetRotation89
;nokia5110.h,735 :: 		}
L_LCD_SetRotation88:
	MOVF        _rotation+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_SetRotation90
	MOVF        _rotation+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_SetRotation91
	MOVF        _rotation+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_SetRotation92
	MOVF        _rotation+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_SetRotation93
L_LCD_SetRotation89:
;nokia5110.h,736 :: 		}
L_end_LCD_SetRotation:
	RETURN      0
; end of _LCD_SetRotation

_LCD_GetRotation:

;nokia5110.h,740 :: 		uint8_t LCD_GetRotation()
;nokia5110.h,742 :: 		return rotation;
	MOVF        _rotation+0, 0 
	MOVWF       R0 
;nokia5110.h,743 :: 		}
L_end_LCD_GetRotation:
	RETURN      0
; end of _LCD_GetRotation

_LCD_GetWidth:

;nokia5110.h,746 :: 		uint8_t LCD_GetWidth()
;nokia5110.h,748 :: 		return _width;
	MOVF        __width+0, 0 
	MOVWF       R0 
;nokia5110.h,749 :: 		}
L_end_LCD_GetWidth:
	RETURN      0
; end of _LCD_GetWidth

_LCD_GetHeight:

;nokia5110.h,752 :: 		uint8_t LCD_GetHeight()
;nokia5110.h,754 :: 		return _height;
	MOVF        __height+0, 0 
	MOVWF       R0 
;nokia5110.h,755 :: 		}
L_end_LCD_GetHeight:
	RETURN      0
; end of _LCD_GetHeight

_LCD_PutC:

;nokia5110.h,763 :: 		void LCD_PutC(uint8_t c)
;nokia5110.h,766 :: 		if(c == '\a') {
	MOVF        FARG_LCD_PutC_c+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC94
;nokia5110.h,767 :: 		x_pos = y_pos = 0;
	CLRF        _y_pos+0 
	MOVF        _y_pos+0, 0 
	MOVWF       _x_pos+0 
;nokia5110.h,768 :: 		return;
	GOTO        L_end_LCD_PutC
;nokia5110.h,769 :: 		}
L_LCD_PutC94:
;nokia5110.h,770 :: 		if (c == ' ' && x_pos == 0 && wrap)
	MOVF        FARG_LCD_PutC_c+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC97
	MOVF        _x_pos+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC97
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutC97
L__LCD_PutC184:
;nokia5110.h,771 :: 		return;
	GOTO        L_end_LCD_PutC
L_LCD_PutC97:
;nokia5110.h,772 :: 		if( (c == '\b') && (x_pos >= text_size * 6) ) {
	MOVF        FARG_LCD_PutC_c+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC100
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R1 
	MOVF        PRODH+0, 0 
	MOVWF       R2 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutC254
	MOVF        R1, 0 
	SUBWF       _x_pos+0, 0 
L__LCD_PutC254:
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_PutC100
L__LCD_PutC183:
;nokia5110.h,773 :: 		x_pos -= text_size * 6;
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	SUBWF       _x_pos+0, 1 
;nokia5110.h,774 :: 		return;
	GOTO        L_end_LCD_PutC
;nokia5110.h,775 :: 		}
L_LCD_PutC100:
;nokia5110.h,776 :: 		if(c == '\r') {
	MOVF        FARG_LCD_PutC_c+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC101
;nokia5110.h,777 :: 		x_pos = 0;
	CLRF        _x_pos+0 
;nokia5110.h,778 :: 		return;
	GOTO        L_end_LCD_PutC
;nokia5110.h,779 :: 		}
L_LCD_PutC101:
;nokia5110.h,780 :: 		if(c == '\n') {
	MOVF        FARG_LCD_PutC_c+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC102
;nokia5110.h,781 :: 		y_pos += text_size * 8;
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 1 
;nokia5110.h,782 :: 		if((y_pos + text_size * 7) > _height)
	MOVLW       7
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        _y_pos+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutC255
	MOVF        R2, 0 
	SUBWF       __height+0, 0 
L__LCD_PutC255:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutC103
;nokia5110.h,783 :: 		y_pos = 0;
	CLRF        _y_pos+0 
L_LCD_PutC103:
;nokia5110.h,784 :: 		return;
	GOTO        L_end_LCD_PutC
;nokia5110.h,785 :: 		}
L_LCD_PutC102:
;nokia5110.h,787 :: 		if((c < ' ') || (c > '~'))
	MOVLW       32
	SUBWF       FARG_LCD_PutC_c+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__LCD_PutC182
	MOVF        FARG_LCD_PutC_c+0, 0 
	SUBLW       126
	BTFSS       STATUS+0, 0 
	GOTO        L__LCD_PutC182
	GOTO        L_LCD_PutC106
L__LCD_PutC182:
;nokia5110.h,788 :: 		c = '?';
	MOVLW       63
	MOVWF       FARG_LCD_PutC_c+0 
L_LCD_PutC106:
;nokia5110.h,790 :: 		for(i = 0; i < 5; i++ ) {
	CLRF        LCD_PutC_i_L0+0 
L_LCD_PutC107:
	MOVLW       5
	SUBWF       LCD_PutC_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutC108
;nokia5110.h,791 :: 		line = Font[(c - ' ') * 5 + i];
	MOVLW       32
	SUBWF       FARG_LCD_PutC_c+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        LCD_PutC_i_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	MOVLW       _Font+0
	ADDWF       R0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_Font+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       higher_addr(_Font+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, LCD_PutC_line_L0+0
;nokia5110.h,792 :: 		for(j = 0; j < 8; j++, line >>= 1) {
	CLRF        LCD_PutC_j_L0+0 
L_LCD_PutC110:
	MOVLW       8
	SUBWF       LCD_PutC_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutC111
;nokia5110.h,793 :: 		if(line & 1) {
	BTFSS       LCD_PutC_line_L0+0, 0 
	GOTO        L_LCD_PutC113
;nokia5110.h,794 :: 		if(text_size == 1)
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC114
;nokia5110.h,795 :: 		LCD_DrawPixel(x_pos + i, y_pos + j, text_color);
	MOVF        LCD_PutC_i_L0+0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_PutC_j_L0+0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        _text_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
	GOTO        L_LCD_PutC115
L_LCD_PutC114:
;nokia5110.h,797 :: 		LCD_FillRect(x_pos + i * text_size, y_pos + j * text_size, text_size, text_size, text_color);
	MOVF        LCD_PutC_i_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        LCD_PutC_j_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        _text_color+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
L_LCD_PutC115:
;nokia5110.h,798 :: 		}
	GOTO        L_LCD_PutC116
L_LCD_PutC113:
;nokia5110.h,800 :: 		if(text_bg != text_color) {
	MOVF        _text_bg+0, 0 
	XORWF       _text_color+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutC117
;nokia5110.h,801 :: 		if(text_size == 1)
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC118
;nokia5110.h,802 :: 		LCD_DrawPixel(x_pos + i, y_pos + j, text_bg);
	MOVF        LCD_PutC_i_L0+0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_PutC_j_L0+0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
	GOTO        L_LCD_PutC119
L_LCD_PutC118:
;nokia5110.h,804 :: 		LCD_FillRect(x_pos + i * text_size, y_pos + j * text_size, text_size, text_size, text_bg);
	MOVF        LCD_PutC_i_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        LCD_PutC_j_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
L_LCD_PutC119:
;nokia5110.h,805 :: 		}
L_LCD_PutC117:
L_LCD_PutC116:
;nokia5110.h,792 :: 		for(j = 0; j < 8; j++, line >>= 1) {
	INCF        LCD_PutC_j_L0+0, 1 
	RRCF        LCD_PutC_line_L0+0, 1 
	BCF         LCD_PutC_line_L0+0, 7 
;nokia5110.h,806 :: 		}
	GOTO        L_LCD_PutC110
L_LCD_PutC111:
;nokia5110.h,790 :: 		for(i = 0; i < 5; i++ ) {
	INCF        LCD_PutC_i_L0+0, 1 
;nokia5110.h,807 :: 		}
	GOTO        L_LCD_PutC107
L_LCD_PutC108:
;nokia5110.h,809 :: 		if(text_bg != text_color) {  // If opaque, draw vertical line for last column
	MOVF        _text_bg+0, 0 
	XORWF       _text_color+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutC120
;nokia5110.h,810 :: 		if(text_size == 1) LCD_DrawVLine(x_pos + 5, y_pos, 8, text_bg);
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutC121
	MOVLW       5
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        _y_pos+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       8
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
	GOTO        L_LCD_PutC122
L_LCD_PutC121:
;nokia5110.h,811 :: 		else               LCD_FillRect(x_pos + 5 * text_size, y_pos, text_size, 8 * text_size, text_bg);
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        _y_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
L_LCD_PutC122:
;nokia5110.h,812 :: 		}
L_LCD_PutC120:
;nokia5110.h,814 :: 		x_pos += text_size * 6;
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 1 
;nokia5110.h,816 :: 		if( x_pos > (_width + text_size * 6) )
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        __width+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutC256
	MOVF        _x_pos+0, 0 
	SUBWF       R2, 0 
L__LCD_PutC256:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutC123
;nokia5110.h,817 :: 		x_pos = _width;
	MOVF        __width+0, 0 
	MOVWF       _x_pos+0 
L_LCD_PutC123:
;nokia5110.h,819 :: 		if (wrap && (x_pos + (text_size * 5)) > _width)
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutC126
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        _x_pos+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutC257
	MOVF        R2, 0 
	SUBWF       __width+0, 0 
L__LCD_PutC257:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutC126
L__LCD_PutC181:
;nokia5110.h,821 :: 		x_pos = 0;
	CLRF        _x_pos+0 
;nokia5110.h,822 :: 		y_pos += text_size * 8;
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 1 
;nokia5110.h,823 :: 		if( y_pos > (_height + text_size * 8) )
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        __height+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutC258
	MOVF        _y_pos+0, 0 
	SUBWF       R2, 0 
L__LCD_PutC258:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutC127
;nokia5110.h,824 :: 		y_pos = _height;
	MOVF        __height+0, 0 
	MOVWF       _y_pos+0 
L_LCD_PutC127:
;nokia5110.h,825 :: 		}
L_LCD_PutC126:
;nokia5110.h,826 :: 		}
L_end_LCD_PutC:
	RETURN      0
; end of _LCD_PutC

_LCD_PutCustomC:

;nokia5110.h,829 :: 		void LCD_PutCustomC(const uint8_t *c)
;nokia5110.h,833 :: 		for(i = 0; i < 5; i++ ) {
	CLRF        LCD_PutCustomC_i_L0+0 
L_LCD_PutCustomC128:
	MOVLW       5
	SUBWF       LCD_PutCustomC_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutCustomC129
;nokia5110.h,834 :: 		line = c[i];
	MOVF        LCD_PutCustomC_i_L0+0, 0 
	ADDWF       FARG_LCD_PutCustomC_c+0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       0
	ADDWFC      FARG_LCD_PutCustomC_c+1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      FARG_LCD_PutCustomC_c+2, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, LCD_PutCustomC_line_L0+0
;nokia5110.h,836 :: 		for(j = 0; j < 8; j++, line >>= 1) {
	CLRF        LCD_PutCustomC_j_L0+0 
L_LCD_PutCustomC131:
	MOVLW       8
	SUBWF       LCD_PutCustomC_j_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutCustomC132
;nokia5110.h,837 :: 		if(line & 1) {
	BTFSS       LCD_PutCustomC_line_L0+0, 0 
	GOTO        L_LCD_PutCustomC134
;nokia5110.h,838 :: 		if(text_size == 1)
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutCustomC135
;nokia5110.h,839 :: 		LCD_DrawPixel(x_pos + i, y_pos + j, text_color);
	MOVF        LCD_PutCustomC_i_L0+0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_PutCustomC_j_L0+0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        _text_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
	GOTO        L_LCD_PutCustomC136
L_LCD_PutCustomC135:
;nokia5110.h,841 :: 		LCD_FillRect(x_pos + i * text_size, y_pos + j * text_size, text_size, text_size, text_color);
	MOVF        LCD_PutCustomC_i_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        LCD_PutCustomC_j_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        _text_color+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
L_LCD_PutCustomC136:
;nokia5110.h,842 :: 		}
	GOTO        L_LCD_PutCustomC137
L_LCD_PutCustomC134:
;nokia5110.h,844 :: 		if(text_bg != text_color) {
	MOVF        _text_bg+0, 0 
	XORWF       _text_color+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutCustomC138
;nokia5110.h,845 :: 		if(text_size == 1)
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutCustomC139
;nokia5110.h,846 :: 		LCD_DrawPixel(x_pos + i, y_pos + j, text_bg);
	MOVF        LCD_PutCustomC_i_L0+0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVF        LCD_PutCustomC_j_L0+0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
	GOTO        L_LCD_PutCustomC140
L_LCD_PutCustomC139:
;nokia5110.h,848 :: 		LCD_FillRect(x_pos + i * text_size, y_pos + j * text_size, text_size, text_size, text_bg);
	MOVF        LCD_PutCustomC_i_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        LCD_PutCustomC_j_L0+0, 0 
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
L_LCD_PutCustomC140:
;nokia5110.h,849 :: 		}
L_LCD_PutCustomC138:
L_LCD_PutCustomC137:
;nokia5110.h,836 :: 		for(j = 0; j < 8; j++, line >>= 1) {
	INCF        LCD_PutCustomC_j_L0+0, 1 
	RRCF        LCD_PutCustomC_line_L0+0, 1 
	BCF         LCD_PutCustomC_line_L0+0, 7 
;nokia5110.h,850 :: 		}
	GOTO        L_LCD_PutCustomC131
L_LCD_PutCustomC132:
;nokia5110.h,833 :: 		for(i = 0; i < 5; i++ ) {
	INCF        LCD_PutCustomC_i_L0+0, 1 
;nokia5110.h,851 :: 		}
	GOTO        L_LCD_PutCustomC128
L_LCD_PutCustomC129:
;nokia5110.h,853 :: 		if(text_bg != text_color) {  // If opaque, draw vertical line for last column
	MOVF        _text_bg+0, 0 
	XORWF       _text_color+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutCustomC141
;nokia5110.h,854 :: 		if(text_size == 1) LCD_DrawVLine(x_pos + 5, y_pos, 8, text_bg);
	MOVF        _text_size+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_PutCustomC142
	MOVLW       5
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_DrawVLine_x+0 
	MOVF        _y_pos+0, 0 
	MOVWF       FARG_LCD_DrawVLine_y+0 
	MOVLW       8
	MOVWF       FARG_LCD_DrawVLine_h+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_DrawVLine_color+0 
	CALL        _LCD_DrawVLine+0, 0
	GOTO        L_LCD_PutCustomC143
L_LCD_PutCustomC142:
;nokia5110.h,855 :: 		else               LCD_FillRect(x_pos + 5 * text_size, y_pos, text_size, 8 * text_size, text_bg);
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_x+0 
	MOVF        _y_pos+0, 0 
	MOVWF       FARG_LCD_FillRect_y+0 
	MOVF        _text_size+0, 0 
	MOVWF       FARG_LCD_FillRect_w+0 
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       FARG_LCD_FillRect_h+0 
	MOVF        _text_bg+0, 0 
	MOVWF       FARG_LCD_FillRect_color+0 
	CALL        _LCD_FillRect+0, 0
L_LCD_PutCustomC143:
;nokia5110.h,856 :: 		}
L_LCD_PutCustomC141:
;nokia5110.h,858 :: 		x_pos += text_size * 6;
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _x_pos+0, 1 
;nokia5110.h,860 :: 		if( x_pos > (_width + text_size * 6) )
	MOVLW       6
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        __width+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutCustomC260
	MOVF        _x_pos+0, 0 
	SUBWF       R2, 0 
L__LCD_PutCustomC260:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutCustomC144
;nokia5110.h,861 :: 		x_pos = _width;
	MOVF        __width+0, 0 
	MOVWF       _x_pos+0 
L_LCD_PutCustomC144:
;nokia5110.h,863 :: 		if (wrap && (x_pos + (text_size * 5)) > _width)
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_PutCustomC147
	MOVLW       5
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        _x_pos+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutCustomC261
	MOVF        R2, 0 
	SUBWF       __width+0, 0 
L__LCD_PutCustomC261:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutCustomC147
L__LCD_PutCustomC185:
;nokia5110.h,865 :: 		x_pos = 0;
	CLRF        _x_pos+0 
;nokia5110.h,866 :: 		y_pos += text_size * 8;
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       _y_pos+0, 1 
;nokia5110.h,867 :: 		if( y_pos > (_height + text_size * 8) )
	MOVLW       8
	MULWF       _text_size+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        __height+0, 0 
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVLW       128
	XORWF       R3, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_PutCustomC262
	MOVF        _y_pos+0, 0 
	SUBWF       R2, 0 
L__LCD_PutCustomC262:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_PutCustomC148
;nokia5110.h,868 :: 		y_pos = _height;
	MOVF        __height+0, 0 
	MOVWF       _y_pos+0 
L_LCD_PutCustomC148:
;nokia5110.h,869 :: 		}
L_LCD_PutCustomC147:
;nokia5110.h,870 :: 		}
L_end_LCD_PutCustomC:
	RETURN      0
; end of _LCD_PutCustomC

_LCD_Print:

;nokia5110.h,873 :: 		void LCD_Print(char *s)
;nokia5110.h,875 :: 		while (*s)
L_LCD_Print149:
	MOVFF       FARG_LCD_Print_s+0, FSR0L+0
	MOVFF       FARG_LCD_Print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_Print150
;nokia5110.h,877 :: 		if (*s == ' ' && x_pos == 0 && wrap)
	MOVFF       FARG_LCD_Print_s+0, FSR0L+0
	MOVFF       FARG_LCD_Print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Print153
	MOVF        _x_pos+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Print153
	MOVF        _wrap+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_Print153
L__LCD_Print186:
;nokia5110.h,878 :: 		*s++;
	INFSNZ      FARG_LCD_Print_s+0, 1 
	INCF        FARG_LCD_Print_s+1, 1 
	GOTO        L_LCD_Print154
L_LCD_Print153:
;nokia5110.h,880 :: 		LCD_PutC(*s++);
	MOVFF       FARG_LCD_Print_s+0, FSR0L+0
	MOVFF       FARG_LCD_Print_s+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_LCD_PutC_c+0 
	CALL        _LCD_PutC+0, 0
	INFSNZ      FARG_LCD_Print_s+0, 1 
	INCF        FARG_LCD_Print_s+1, 1 
L_LCD_Print154:
;nokia5110.h,881 :: 		}
	GOTO        L_LCD_Print149
L_LCD_Print150:
;nokia5110.h,882 :: 		}
L_end_LCD_Print:
	RETURN      0
; end of _LCD_Print

_LCD_Invert:

;nokia5110.h,884 :: 		void LCD_Invert(bool inv)
;nokia5110.h,886 :: 		if(inv == 1)
	MOVF        FARG_LCD_Invert_inv+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Invert155
;nokia5110.h,887 :: 		write_command(LCD_DISPLAYCONTROL | LCD_DISPLAYINVERTED);
	MOVLW       13
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
	GOTO        L_LCD_Invert156
L_LCD_Invert155:
;nokia5110.h,889 :: 		write_command(LCD_DISPLAYCONTROL | LCD_DISPLAYNORMAL);
	MOVLW       12
	MOVWF       FARG_write_command_c_+0 
	CALL        _write_command+0, 0
L_LCD_Invert156:
;nokia5110.h,890 :: 		}
L_end_LCD_Invert:
	RETURN      0
; end of _LCD_Invert

_LCD_ROMBMP:

;nokia5110.h,893 :: 		void LCD_ROMBMP(uint8_t x, uint8_t y, const uint8_t *bitmap, uint8_t w, uint8_t h, bool color)
;nokia5110.h,896 :: 		for( i = 0; i < h/8; i++)
	CLRF        LCD_ROMBMP_i_L0+0 
	CLRF        LCD_ROMBMP_i_L0+1 
L_LCD_ROMBMP157:
	MOVLW       8
	MOVWF       R4 
	MOVF        FARG_LCD_ROMBMP_h+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       0
	SUBWF       LCD_ROMBMP_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_ROMBMP266
	MOVF        R0, 0 
	SUBWF       LCD_ROMBMP_i_L0+0, 0 
L__LCD_ROMBMP266:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_ROMBMP158
;nokia5110.h,898 :: 		for( j = 0; j < (uint16_t)w * 8; j++)
	CLRF        LCD_ROMBMP_j_L0+0 
	CLRF        LCD_ROMBMP_j_L0+1 
L_LCD_ROMBMP160:
	MOVF        FARG_LCD_ROMBMP_w+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R1, 0 
	SUBWF       LCD_ROMBMP_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_ROMBMP267
	MOVF        R0, 0 
	SUBWF       LCD_ROMBMP_j_L0+0, 0 
L__LCD_ROMBMP267:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_ROMBMP161
;nokia5110.h,900 :: 		if( bitmap[j/8 + i*w] & (1 << (j % 8)) )
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_ROMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_ROMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LCD_ROMBMP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LCD_ROMBMP+1 
	MOVF        LCD_ROMBMP_i_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_ROMBMP_i_L0+1, 0 
	MOVWF       R1 
	MOVF        FARG_LCD_ROMBMP_w+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__LCD_ROMBMP+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__LCD_ROMBMP+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LCD_ROMBMP_bitmap+0, 0 
	MOVWF       TBLPTR+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LCD_ROMBMP_bitmap+1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      FARG_LCD_ROMBMP_bitmap+2, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__LCD_ROMBMP+0
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_ROMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_ROMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__LCD_ROMBMP268:
	BZ          L__LCD_ROMBMP269
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__LCD_ROMBMP268
L__LCD_ROMBMP269:
	MOVF        FLOC__LCD_ROMBMP+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_ROMBMP163
;nokia5110.h,901 :: 		LCD_DrawPixel(x + j/8, y + i*8 + (j % 8), color);
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_ROMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_ROMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_LCD_ROMBMP_x+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVLW       8
	MULWF       LCD_ROMBMP_i_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_LCD_ROMBMP_y+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_ROMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_ROMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_LCD_DrawPixel_y+0, 1 
	MOVF        FARG_LCD_ROMBMP_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
L_LCD_ROMBMP163:
;nokia5110.h,898 :: 		for( j = 0; j < (uint16_t)w * 8; j++)
	INFSNZ      LCD_ROMBMP_j_L0+0, 1 
	INCF        LCD_ROMBMP_j_L0+1, 1 
;nokia5110.h,902 :: 		}
	GOTO        L_LCD_ROMBMP160
L_LCD_ROMBMP161:
;nokia5110.h,896 :: 		for( i = 0; i < h/8; i++)
	INFSNZ      LCD_ROMBMP_i_L0+0, 1 
	INCF        LCD_ROMBMP_i_L0+1, 1 
;nokia5110.h,903 :: 		}
	GOTO        L_LCD_ROMBMP157
L_LCD_ROMBMP158:
;nokia5110.h,904 :: 		}
L_end_LCD_ROMBMP:
	RETURN      0
; end of _LCD_ROMBMP

_LCD_RAMBMP:

;nokia5110.h,907 :: 		void LCD_RAMBMP(uint8_t x, uint8_t y, uint8_t *bitmap, uint8_t w, uint8_t h, bool color)
;nokia5110.h,910 :: 		for( i = 0; i < h/8; i++)
	CLRF        LCD_RAMBMP_i_L0+0 
	CLRF        LCD_RAMBMP_i_L0+1 
L_LCD_RAMBMP164:
	MOVLW       8
	MOVWF       R4 
	MOVF        FARG_LCD_RAMBMP_h+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVLW       0
	SUBWF       LCD_RAMBMP_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_RAMBMP271
	MOVF        R0, 0 
	SUBWF       LCD_RAMBMP_i_L0+0, 0 
L__LCD_RAMBMP271:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_RAMBMP165
;nokia5110.h,912 :: 		for( j = 0; j < (uint16_t)w * 8; j++)
	CLRF        LCD_RAMBMP_j_L0+0 
	CLRF        LCD_RAMBMP_j_L0+1 
L_LCD_RAMBMP167:
	MOVF        FARG_LCD_RAMBMP_w+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R1, 0 
	SUBWF       LCD_RAMBMP_j_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__LCD_RAMBMP272
	MOVF        R0, 0 
	SUBWF       LCD_RAMBMP_j_L0+0, 0 
L__LCD_RAMBMP272:
	BTFSC       STATUS+0, 0 
	GOTO        L_LCD_RAMBMP168
;nokia5110.h,914 :: 		if( bitmap[j/8 + i*w] & (1 << (j % 8)) )
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_RAMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_RAMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__LCD_RAMBMP+0 
	MOVF        R1, 0 
	MOVWF       FLOC__LCD_RAMBMP+1 
	MOVF        LCD_RAMBMP_i_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_RAMBMP_i_L0+1, 0 
	MOVWF       R1 
	MOVF        FARG_LCD_RAMBMP_w+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__LCD_RAMBMP+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__LCD_RAMBMP+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_LCD_RAMBMP_bitmap+0, 0 
	MOVWF       FSR0L+0 
	MOVF        R1, 0 
	ADDWFC      FARG_LCD_RAMBMP_bitmap+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_RAMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_RAMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__LCD_RAMBMP273:
	BZ          L__LCD_RAMBMP274
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__LCD_RAMBMP273
L__LCD_RAMBMP274:
	MOVF        POSTINC0+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_RAMBMP170
;nokia5110.h,915 :: 		LCD_DrawPixel(x + j/8, y + i*8 + (j % 8), color);
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_RAMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_RAMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FARG_LCD_RAMBMP_x+0, 0 
	MOVWF       FARG_LCD_DrawPixel_x+0 
	MOVLW       8
	MULWF       LCD_RAMBMP_i_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDWF       FARG_LCD_RAMBMP_y+0, 0 
	MOVWF       FARG_LCD_DrawPixel_y+0 
	MOVLW       8
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        LCD_RAMBMP_j_L0+0, 0 
	MOVWF       R0 
	MOVF        LCD_RAMBMP_j_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_LCD_DrawPixel_y+0, 1 
	MOVF        FARG_LCD_RAMBMP_color+0, 0 
	MOVWF       FARG_LCD_DrawPixel_color+0 
	CALL        _LCD_DrawPixel+0, 0
L_LCD_RAMBMP170:
;nokia5110.h,912 :: 		for( j = 0; j < (uint16_t)w * 8; j++)
	INFSNZ      LCD_RAMBMP_j_L0+0, 1 
	INCF        LCD_RAMBMP_j_L0+1, 1 
;nokia5110.h,916 :: 		}
	GOTO        L_LCD_RAMBMP167
L_LCD_RAMBMP168:
;nokia5110.h,910 :: 		for( i = 0; i < h/8; i++)
	INFSNZ      LCD_RAMBMP_i_L0+0, 1 
	INCF        LCD_RAMBMP_i_L0+1, 1 
;nokia5110.h,917 :: 		}
	GOTO        L_LCD_RAMBMP164
L_LCD_RAMBMP165:
;nokia5110.h,918 :: 		}
L_end_LCD_RAMBMP:
	RETURN      0
; end of _LCD_RAMBMP

_InitHW:

;PIC16LF747_TEST.c,65 :: 		void InitHW(){
;PIC16LF747_TEST.c,70 :: 		PORTA = 0x00;                          // Priprava pro konfiguraci portu PORT A
	CLRF        PORTA+0 
;PIC16LF747_TEST.c,71 :: 		PORTB = 0x00;                          // PORT B
	CLRF        PORTB+0 
;PIC16LF747_TEST.c,72 :: 		PORTC = 0x00;                          // PORT C
	CLRF        PORTC+0 
;PIC16LF747_TEST.c,73 :: 		PORTD = 0x00;                          // PORT D
	CLRF        PORTD+0 
;PIC16LF747_TEST.c,74 :: 		PORTE = 0x00;                          // PORT E
	CLRF        PORTE+0 
;PIC16LF747_TEST.c,76 :: 		TRISA = 0b00000000;                    // Nastaveni I/O 0=Output / 1=Input
	CLRF        TRISA+0 
;PIC16LF747_TEST.c,77 :: 		TRISB = 0b00000000;                    // PORTB 8-bit I/O
	CLRF        TRISB+0 
;PIC16LF747_TEST.c,78 :: 		TRISC = 0b00000000;                    // PORTC 8-bit I/O
	CLRF        TRISC+0 
;PIC16LF747_TEST.c,79 :: 		TRISE = 0b00000000;
	CLRF        TRISE+0 
;PIC16LF747_TEST.c,81 :: 		} // end Init
L_end_InitHW:
	RETURN      0
; end of _InitHW

_LED_Blik:

;PIC16LF747_TEST.c,85 :: 		void LED_Blik() {
;PIC16LF747_TEST.c,86 :: 		RC6 = 1;
	BSF         PORTC+0, 6 
;PIC16LF747_TEST.c,87 :: 		Delay_ms(20);
	MOVLW       170
	MOVWF       R13, 0
L_LED_Blik171:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Blik171
	NOP
;PIC16LF747_TEST.c,88 :: 		RC6 = 0;
	BCF         PORTC+0, 6 
;PIC16LF747_TEST.c,89 :: 		Delay_ms(40);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       83
	MOVWF       R13, 0
L_LED_Blik172:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Blik172
	DECFSZ      R12, 1, 1
	BRA         L_LED_Blik172
;PIC16LF747_TEST.c,90 :: 		RC6 = 1;
	BSF         PORTC+0, 6 
;PIC16LF747_TEST.c,91 :: 		Delay_ms(20);
	MOVLW       170
	MOVWF       R13, 0
L_LED_Blik173:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Blik173
	NOP
;PIC16LF747_TEST.c,92 :: 		RC6 = 0;
	BCF         PORTC+0, 6 
;PIC16LF747_TEST.c,93 :: 		Delay_ms(1000);
	MOVLW       34
	MOVWF       R12, 0
	MOVLW       60
	MOVWF       R13, 0
L_LED_Blik174:
	DECFSZ      R13, 1, 1
	BRA         L_LED_Blik174
	DECFSZ      R12, 1, 1
	BRA         L_LED_Blik174
	NOP
	NOP
;PIC16LF747_TEST.c,95 :: 		}
L_end_LED_Blik:
	RETURN      0
; end of _LED_Blik

_main:

;PIC16LF747_TEST.c,98 :: 		void main() {
;PIC16LF747_TEST.c,99 :: 		InitHW();
	CALL        _InitHW+0, 0
;PIC16LF747_TEST.c,100 :: 		LCD_Begin();                                  // initialize the LCD
	CALL        _LCD_Begin+0, 0
;PIC16LF747_TEST.c,101 :: 		LCD_SetContrast(120);                          // set LCD contrast
	MOVLW       120
	MOVWF       FARG_LCD_SetContrast_con+0 
	CALL        _LCD_SetContrast+0, 0
;PIC16LF747_TEST.c,102 :: 		LCD_Fill();                                   // test LCD pixels
	CALL        _LCD_Fill+0, 0
;PIC16LF747_TEST.c,103 :: 		LCD_Display();                                // show splashscreen (kyticka logo)
	CALL        _LCD_Display+0, 0
;PIC16LF747_TEST.c,104 :: 		Delay_ms(500);
	MOVLW       17
	MOVWF       R12, 0
	MOVLW       158
	MOVWF       R13, 0
L_main175:
	DECFSZ      R13, 1, 1
	BRA         L_main175
	DECFSZ      R12, 1, 1
	BRA         L_main175
;PIC16LF747_TEST.c,105 :: 		LCD_Clear();                                  // clear the display buffer
	CALL        _LCD_Clear+0, 0
;PIC16LF747_TEST.c,107 :: 		LCD_TextSize(1);                              // set text size to 1
	MOVLW       1
	MOVWF       FARG_LCD_TextSize_t_size+0 
	CALL        _LCD_TextSize+0, 0
;PIC16LF747_TEST.c,108 :: 		LCD_TextColor(BLACK, WHITE);                  // set text color to black with white background
	MOVLW       1
	MOVWF       FARG_LCD_TextColor_t_color+0 
	CLRF        FARG_LCD_TextColor_t_bg+0 
	CALL        _LCD_TextColor+0, 0
;PIC16LF747_TEST.c,109 :: 		LCD_GotoXY(7, 3);                             // move cursor to position
	MOVLW       7
	MOVWF       FARG_LCD_GotoXY_x+0 
	MOVLW       3
	MOVWF       FARG_LCD_GotoXY_y+0 
	CALL        _LCD_GotoXY+0, 0
;PIC16LF747_TEST.c,110 :: 		LCD_Print("Teplota C");
	MOVLW       ?lstr1_PIC16LF747_TEST+0
	MOVWF       FARG_LCD_Print_s+0 
	MOVLW       hi_addr(?lstr1_PIC16LF747_TEST+0)
	MOVWF       FARG_LCD_Print_s+1 
	CALL        _LCD_Print+0, 0
;PIC16LF747_TEST.c,111 :: 		LCD_DrawRect(51, 3, 3, 3, BLACK);             // print degree symbol ( ° )
	MOVLW       51
	MOVWF       FARG_LCD_DrawRect_x+0 
	MOVLW       3
	MOVWF       FARG_LCD_DrawRect_y+0 
	MOVLW       3
	MOVWF       FARG_LCD_DrawRect_w+0 
	MOVLW       3
	MOVWF       FARG_LCD_DrawRect_h+0 
	MOVLW       1
	MOVWF       FARG_LCD_DrawRect_color+0 
	CALL        _LCD_DrawRect+0, 0
;PIC16LF747_TEST.c,112 :: 		LCD_DrawRoundRect(0, 0, 84, 48, 7, BLACK);    // obly ramecek
	CLRF        FARG_LCD_DrawRoundRect_x+0 
	CLRF        FARG_LCD_DrawRoundRect_y+0 
	MOVLW       84
	MOVWF       FARG_LCD_DrawRoundRect_w+0 
	MOVLW       48
	MOVWF       FARG_LCD_DrawRoundRect_h+0 
	MOVLW       7
	MOVWF       FARG_LCD_DrawRoundRect_r+0 
	MOVLW       1
	MOVWF       FARG_LCD_DrawRoundRect_color+0 
	CALL        _LCD_DrawRoundRect+0, 0
;PIC16LF747_TEST.c,113 :: 		LCD_Display();
	CALL        _LCD_Display+0, 0
;PIC16LF747_TEST.c,115 :: 		while (1) {
L_main176:
;PIC16LF747_TEST.c,117 :: 		LED_Blik();
	CALL        _LED_Blik+0, 0
;PIC16LF747_TEST.c,119 :: 		}//end loop
	GOTO        L_main176
;PIC16LF747_TEST.c,122 :: 		}//end main
L_end_main:
	GOTO        $+0
; end of _main
