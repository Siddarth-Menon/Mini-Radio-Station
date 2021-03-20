
;CodeVisionAVR C Compiler V1.24.8d Professional
;(C) Copyright 1998-2006 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega48
;Clock frequency        : 4.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : No
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega48
	#pragma AVRPART MEMORY PROG_FLASH 4096
	#pragma AVRPART MEMORY EEPROM 256
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E
	.EQU GPIOR1=0x2A
	.EQU GPIOR2=0x2B

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "untitled.vec"
	.INCLUDE "untitled.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x200)
	LDI  R25,HIGH(0x200)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0-GPIOR2 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30
	LDI  R30,__GPIOR1_INIT
	OUT  GPIOR1,R30
	LDI  R30,__GPIOR2_INIT
	OUT  GPIOR2,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x2FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x2FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x180)
	LDI  R29,HIGH(0x180)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x180
;       1 #include <mega48.h>
;       2  #include <lcd16x1.h>  
;       3  #include <stdlib.h>  
;       4  #include<delay.h>    
;       5  // I2C Bus functions
;       6 #asm
;       7    .equ __i2c_port=0x0B ;PORTD
   .equ __i2c_port=0x0B ;PORTD
;       8    .equ __sda_bit=2
   .equ __sda_bit=2
;       9    .equ __scl_bit=3
   .equ __scl_bit=3
;      10 #endasm
;      11 #include <i2c.h>
;      12 
;      13 // DS1307 Real Time Clock functions
;      14 #include <ds1307.h>
;      15 
;      16 // SPI functions
;      17 #include <spi.h>
;      18 
;      19 // Declare your global variables here
;      20               unsigned char data;
;      21 void main(void)
;      22 {

	.CSEG
_main:
;      23 // Declare your local variables here
;      24 unsigned char AR[]="siddarth";    
;      25 unsigned char tm[]="TIME: ";
;      26 unsigned char dt[]="DATE: ";    
;      27 unsigned char h,m,s,i;  
;      28 unsigned char hr[3], min[3], sec[3]; 
;      29 unsigned char date, month, year;
;      30 unsigned char date1[3], month1[3], year1[3];
;      31 
;      32 
;      33 // Crystal Oscillator division factor: 1
;      34 #pragma optsize-
;      35 CLKPR=0x80;
	SBIW R28,42
	LDI  R24,23
	LDI  R26,LOW(19)
	LDI  R27,HIGH(19)
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	RCALL __INITLOCB
;	AR -> Y+33
;	tm -> Y+26
;	dt -> Y+19
;	h -> R16
;	m -> R17
;	s -> R18
;	i -> R19
;	hr -> Y+16
;	min -> Y+13
;	sec -> Y+10
;	date -> R20
;	month -> R21
;	year -> Y+9
;	date1 -> Y+6
;	month1 -> Y+3
;	year1 -> Y+0
	LDI  R30,LOW(128)
	STS  97,R30
;      36 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;      37 #ifdef _OPTIMIZE_SIZE_
;      38 #pragma optsize+
;      39 #endif
;      40 
;      41 // Input/Output Ports initialization
;      42 // Port B initialization
;      43 // Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=In Func0=In 
;      44 // State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=T State0=T 
;      45 PORTB=0x00;
	OUT  0x5,R30
;      46 DDRB=0x3f;
	LDI  R30,LOW(63)
	OUT  0x4,R30
;      47 
;      48 // Port C initialization
;      49 // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;      50 // State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;      51 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
;      52 DDRC=0x01;
	LDI  R30,LOW(1)
	OUT  0x7,R30
;      53 
;      54 // Port D initialization
;      55 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;      56 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;      57 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
;      58 DDRD=0xF0;
	LDI  R30,LOW(240)
	OUT  0xA,R30
;      59 
;      60 // Timer/Counter 0 initialization
;      61 // Clock source: System Clock
;      62 // Clock value: Timer 0 Stopped
;      63 // Mode: Normal top=FFh
;      64 // OC0A output: Disconnected
;      65 // OC0B output: Disconnected
;      66 TCCR0A=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
;      67 TCCR0B=0x00;
	OUT  0x25,R30
;      68 TCNT0=0x00;
	OUT  0x26,R30
;      69 OCR0A=0x00;
	OUT  0x27,R30
;      70 OCR0B=0x00;
	OUT  0x28,R30
;      71 
;      72 // Timer/Counter 1 initialization
;      73 // Clock source: System Clock
;      74 // Clock value: Timer 1 Stopped
;      75 // Mode: Normal top=FFFFh
;      76 // OC1A output: Discon.
;      77 // OC1B output: Discon.
;      78 // Noise Canceler: Off
;      79 // Input Capture on Falling Edge
;      80 // Timer 1 Overflow Interrupt: Off
;      81 // Input Capture Interrupt: Off
;      82 // Compare A Match Interrupt: Off
;      83 // Compare B Match Interrupt: Off
;      84 TCCR1A=0x00;
	STS  128,R30
;      85 TCCR1B=0x00;
	STS  129,R30
;      86 TCNT1H=0x00;
	STS  133,R30
;      87 TCNT1L=0x00;
	STS  132,R30
;      88 ICR1H=0x00;
	STS  135,R30
;      89 ICR1L=0x00;
	STS  134,R30
;      90 OCR1AH=0x00;
	STS  137,R30
;      91 OCR1AL=0x00;
	STS  136,R30
;      92 OCR1BH=0x00;
	STS  139,R30
;      93 OCR1BL=0x00;
	STS  138,R30
;      94 
;      95 // Timer/Counter 2 initialization
;      96 // Clock source: System Clock
;      97 // Clock value: Timer 2 Stopped
;      98 // Mode: Normal top=FFh
;      99 // OC2A output: Disconnected
;     100 // OC2B output: Disconnected
;     101 ASSR=0x00;
	STS  182,R30
;     102 TCCR2A=0x00;
	STS  176,R30
;     103 TCCR2B=0x00;
	STS  177,R30
;     104 TCNT2=0x00;
	STS  178,R30
;     105 OCR2A=0x00;
	STS  179,R30
;     106 OCR2B=0x00;
	STS  180,R30
;     107 
;     108 // External Interrupt(s) initialization
;     109 // INT0: Off
;     110 // INT1: Off
;     111 // Interrupt on any change on pins PCINT0-7: Off
;     112 // Interrupt on any change on pins PCINT8-14: Off
;     113 // Interrupt on any change on pins PCINT16-23: Off
;     114 EICRA=0x00;
	STS  105,R30
;     115 EIMSK=0x00;
	OUT  0x1D,R30
;     116 PCICR=0x00;
	STS  104,R30
;     117 
;     118 // Timer/Counter 0 Interrupt(s) initialization
;     119 TIMSK0=0x00;
	STS  110,R30
;     120 // Timer/Counter 1 Interrupt(s) initialization
;     121 TIMSK1=0x00;
	STS  111,R30
;     122 // Timer/Counter 2 Interrupt(s) initialization
;     123 TIMSK2=0x00;
	STS  112,R30
;     124 
;     125 // Analog Comparator initialization
;     126 // Analog Comparator: Off
;     127 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     128 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
;     129 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
;     130 
;     131 // SPI initialization
;     132 // SPI Type: Master
;     133 // SPI Clock Rate: 500.000 kHz
;     134 // SPI Clock Phase: Cycle Half
;     135 // SPI Clock Polarity: Low
;     136 // SPI Data Order: MSB First
;     137 SPCR=0x51;
	LDI  R30,LOW(81)
	OUT  0x2C,R30
;     138 SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;     139 // I2C Bus initialization
;     140 i2c_init();
	RCALL _i2c_init
;     141 
;     142 // DS1307 Real Time Clock initialization
;     143 // Square wave output on pin SQW/OUT: Off
;     144 // SQW/OUT pin state: 0
;     145 rtc_init(0,0,0);
	RCALL SUBOPT_0x0
	RCALL SUBOPT_0x0
	RCALL SUBOPT_0x0
	RCALL _rtc_init
;     146 lcd_init();
	RCALL _lcd_init
;     147  clear_lcd();
	RCALL _clear_lcd
;     148    delay_ms(800);
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	RCALL SUBOPT_0x1
	RCALL _delay_ms
;     149 
;     150     lcd_cmd(0x80);  
	RCALL SUBOPT_0x2
;     151    
;     152   
;     153 while (1)
_0x4:
;     154       {      
;     155       
;     156     rtc_get_time(&h,&m,&s);
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R16
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R18
	RCALL _rtc_get_time
	POP  R18
	POP  R17
	POP  R16
;     157     rtc_get_date(&date, &month, &year);
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R20
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R21
	MOVW R30,R28
	ADIW R30,13
	RCALL SUBOPT_0x1
	RCALL _rtc_get_date
	POP  R21
	POP  R20
;     158 
;     159 	 // Place your code here   
;     160          
;     161 
;     162 
;     163    while(spi(0)!='$')
_0x7:
	RCALL SUBOPT_0x0
	RCALL _spi
	CPI  R30,LOW(0x24)
	BRNE PC+2
	RJMP _0x9
;     164    {    
;     165         
;     166         
;     167     itoa(h,hr);
	MOV  R30,R16
	RCALL SUBOPT_0x3
	MOVW R30,R28
	ADIW R30,18
	RCALL SUBOPT_0x4
;     168     itoa(m,min);
	MOV  R30,R17
	RCALL SUBOPT_0x3
	MOVW R30,R28
	ADIW R30,15
	RCALL SUBOPT_0x4
;     169     itoa(s,sec); 
	MOV  R30,R18
	RCALL SUBOPT_0x3
	MOVW R30,R28
	ADIW R30,12
	RCALL SUBOPT_0x4
;     170     
;     171     itoa(date,date1);
	MOV  R30,R20
	RCALL SUBOPT_0x3
	MOVW R30,R28
	ADIW R30,8
	RCALL SUBOPT_0x4
;     172     itoa(month,month1);
	MOV  R30,R21
	RCALL SUBOPT_0x3
	MOVW R30,R28
	ADIW R30,5
	RCALL SUBOPT_0x4
;     173     itoa(year,year1);
	LDD  R30,Y+9
	RCALL SUBOPT_0x3
	MOVW R30,R28
	ADIW R30,2
	RCALL SUBOPT_0x4
;     174      lcd_cmd(0x80); 
	RCALL SUBOPT_0x2
;     175      lcd_puts(tm); 
	MOVW R30,R28
	ADIW R30,26
	RCALL SUBOPT_0x5
;     176     lcd_puts(hr); 
	MOVW R30,R28
	ADIW R30,16
	RCALL SUBOPT_0x5
;     177     lcd_data(':',0);
	LDI  R30,LOW(58)
	RCALL SUBOPT_0x6
	RCALL _lcd_data
;     178       lcd_puts(min);
	MOVW R30,R28
	ADIW R30,13
	RCALL SUBOPT_0x5
;     179       lcd_data(':',0);
	LDI  R30,LOW(58)
	RCALL SUBOPT_0x6
	RCALL _lcd_data
;     180         lcd_puts(sec);    
	MOVW R30,R28
	ADIW R30,10
	RCALL SUBOPT_0x5
;     181          lcd_cmd(0xc0);
	LDI  R30,LOW(192)
	RCALL SUBOPT_0x7
;     182          lcd_puts(dt); 
	MOVW R30,R28
	ADIW R30,19
	RCALL SUBOPT_0x5
;     183         
;     184          lcd_puts(date1); 
	MOVW R30,R28
	ADIW R30,6
	RCALL SUBOPT_0x5
;     185           lcd_data('/',0); 
	LDI  R30,LOW(47)
	RCALL SUBOPT_0x6
	RCALL _lcd_data
;     186       lcd_puts(month1);
	MOVW R30,R28
	ADIW R30,3
	RCALL SUBOPT_0x5
;     187        lcd_data('/',0); 
	LDI  R30,LOW(47)
	RCALL SUBOPT_0x6
	RCALL _lcd_data
;     188         lcd_puts(year1);  
	MOVW R30,R28
	RCALL SUBOPT_0x5
;     189         };
	RJMP _0x7
_0x9:
;     190       clear_lcd(); 
	RCALL _clear_lcd
;     191       for(i=0; i<16; i++)
	LDI  R19,LOW(0)
_0xB:
	CPI  R19,16
	BRLO PC+2
	RJMP _0xC
;     192       { 
;     193       
;     194    
;     195     lcd_cmd(0x80);	 
	RCALL SUBOPT_0x2
;     196   data=spi(0); 
	RCALL SUBOPT_0x0
	RCALL _spi
	MOV  R2,R30
;     197     lcd_data(data,0);     
	ST   -Y,R2
	RCALL SUBOPT_0x0
	RCALL _lcd_data
;     198   
;     199 }   
_0xA:
	SUBI R19,-1
	RJMP _0xB
_0xC:
;     200         
;     201           
;     202       }
	RJMP _0x4
_0x6:
;     203 }
	ADIW R28,42
_0xD:
	RJMP _0xD
;     204  #include <mega48.h> 
;     205   #include <delay.h>         
;     206 //#include <prototype.h> 
;     207 #include <lcd16x1.h> 
;     208 #include <stdlib.h>
;     209 #include <stdio.h>  
;     210 //#include<prototype.h>     
;     211 //#define INT0_PIN PIND.2         //int0 pin PD.2
;     212 //#define INT1_PIN PIND.3         //int1 pin PD.3
;     213 
;     214 #define RS PORTB.0
;     215 #define RW PORTB.1    //lcd defines
;     216 #define EN PORTB.2  
;     217                         
;     218          
;     219 
;     220 //function to clear the lcd & start from first row first column onwards       
;     221 void clear_lcd(void)
;     222 {
_clear_lcd:
;     223        lcd_cmd(0x01);
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x7
;     224        //lcd_cmd(0x80);   //clear screen n start from fist line first column
;     225        lcd_cmd(0x06);     //incremental cursor
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x7
;     226 }
	RET
;     227 
;     228 //lcd initialization function for 4 datalines    
;     229  void lcd_init(void)
;     230  {
_lcd_init:
;     231         delay_ms(15);               //startup delay
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RCALL SUBOPT_0x8
;     232                   lcd_cmd(0x03);
;     233         delay_ms(5);     
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0x8
;     234                   lcd_cmd(0x03);
;     235         delay_us(160);     
	RCALL SUBOPT_0x9
;     236                   lcd_cmd(0x03);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x7
;     237         delay_us(160);            
	RCALL SUBOPT_0x9
;     238                   lcd_cmd(0x02);
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x7
;     239        delay_us(160);  
	RCALL SUBOPT_0x9
;     240                   lcd_cmd(0x28);         //4 bit data , 5*7, 2 line..   //the abouve cmds are necessary
	LDI  R30,LOW(40)
	RCALL SUBOPT_0x7
;     241        delay_ms(100);                    
	RCALL SUBOPT_0xA
;     242                   lcd_cmd(0x60);         // set CGRAM addr
	LDI  R30,LOW(96)
	RCALL SUBOPT_0x7
;     243        delay_ms(100);           
	RCALL SUBOPT_0xA
;     244          lcd_cmd(0x0C); 
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x7
;     245        delay_ms(1);                          
	RCALL SUBOPT_0xB
;     246                   lcd_cmd(0x06);       //increment cursor no shift
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x7
;     247        delay_ms(1);           
	RCALL SUBOPT_0xB
;     248                   lcd_cmd(0x90);       // 1st column 1st char
	LDI  R30,LOW(144)
	RCALL SUBOPT_0x7
;     249         delay_ms(1);                                        
	RCALL SUBOPT_0xB
;     250                   lcd_cmd(0x01);       //clear lcd
	LDI  R30,LOW(1)
	RCALL SUBOPT_0x7
;     251         delay_ms(2);                              
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x1
	RCALL _delay_ms
;     252   }
	RET
;     253   //to send lcd commands
;     254 void lcd_cmd(unsigned char inst)
;     255 {
_lcd_cmd:
;     256 
;     257        unsigned char lsb=0,msb=0;
;     258         lsb=inst&0x0F;        //split msb n lsb nibbles
	RCALL __SAVELOCR2
;	inst -> Y+2
;	lsb -> R16
;	msb -> R17
	LDI  R16,0
	LDI  R17,0
	LDD  R30,Y+2
	ANDI R30,LOW(0xF)
	MOV  R16,R30
;     259         msb=inst>>4; 
	LDD  R30,Y+2
	SWAP R30
	ANDI R30,0xF
	MOV  R17,R30
;     260         msb&=0x0F;   
	ANDI R17,LOW(15)
;     261         lsb=lsb&0X0F;
	ANDI R16,LOW(15)
;     262         msb=msb<<4;
	SWAP R17
	ANDI R17,0xF0
;     263         lsb=lsb<<4;
	SWAP R16
	ANDI R16,0xF0
;     264         delay_us(500);            //busy check duration       500
	__DELAY_USW 500
;     265         RS=0;
	CBI  0x5,0
;     266         RW=0;    
	RCALL SUBOPT_0xC
;     267         EN=1;     
;     268         PORTD&=0x0F; 
;     269         PORTD|=msb; 
;     270         delay_us(5);         //6 nops       changed from 10u to 5u
;     271         EN=0;
;     272         delay_us(5);         //6 nops
;     273         EN=1;
;     274         PORTD&=0x0F;        //sending lsb now       
;     275         PORTD|=lsb; 
;     276         delay_us(5);         //6 nops
;     277         EN=0;
;     278      }   
	RCALL __LOADLOCR2
	ADIW R28,3
	RET
;     279                
;     280 //function to send data to lcd
;     281  void lcd_data(unsigned char data1,unsigned char type)
;     282  {      
_lcd_data:
;     283       unsigned char lsbc,msbc,temp,a; 
;     284       type=a;
	RCALL __SAVELOCR4
;	data1 -> Y+5
;	type -> Y+4
;	lsbc -> R16
;	msbc -> R17
;	temp -> R18
;	a -> R19
	STD  Y+4,R19
;     285       temp=0;lsbc=0;msbc=0;
	LDI  R18,LOW(0)
	LDI  R16,LOW(0)
	LDI  R17,LOW(0)
;     286       msbc=data1&0xF0;      //msb n lsb split
	LDD  R30,Y+5
	ANDI R30,LOW(0xF0)
	MOV  R17,R30
;     287       lsbc=data1<<4;
	LDD  R30,Y+5
	SWAP R30
	ANDI R30,0xF0
	MOV  R16,R30
;     288       delay_us(600);            //busy check duration       prev 600
	__DELAY_USW 600
;     289       RS=1;
	SBI  0x5,0
;     290       RW=0;     
	RCALL SUBOPT_0xC
;     291       EN=1;
;     292       PORTD&=0x0F; 
;     293       PORTD|=msbc;         // this being moved to the lsbbits of port instead of msb...
;     294       delay_us(5);        
;     295       EN=0 ;                   
;     296       delay_us(5);        
;     297       EN=1;
;     298       PORTD&=0x0F;
;     299       PORTD|=lsbc;        
;     300       delay_us(5);        
;     301       EN=0;     
;     302 } 
	RCALL __LOADLOCR4
	ADIW R28,6
	RET
;     303             
;     304  
;     305 //function to put string onto lcd     
;     306 void lcd_puts(unsigned char *str)
;     307 {
_lcd_puts:
;     308   while(*str !='\0') 
;	*str -> Y+0
_0xE:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X
	CPI  R30,0
	BRNE PC+2
	RJMP _0x10
;     309          {     
;     310 
;     311            lcd_data(*str,1);
	RCALL SUBOPT_0xD
	LD   R30,X
	ST   -Y,R30
	RCALL SUBOPT_0xE
	RCALL _lcd_data
;     312              *str++;
	RCALL SUBOPT_0xD
	LD   R30,X+
	ST   Y,R26
	STD  Y+1,R27
;     313           }
	RJMP _0xE
_0x10:
;     314 }
	ADIW R28,2
	RET
;     315 
;     316 
;     317 
;     318 
;     319 //function to convert int to ascii for dispaly on lcd / serial port          
;     320 //  //calculate the ascii values to be displayed on lcd  3 digit int to 3 digit ascii
;     321 // void cal_ascii(unsigned int value)   
;     322 // { 
;     323 //        unsigned char lb,mb,mmlb;
;     324 //        mmlb=(((unsigned char)(value/100))|0x30);
;     325 //        mb=(unsigned char)(value/10);  
;     326 //        mb=(((unsigned char)(mb%10))|0x30);
;     327 //        lb=(((unsigned char)(value%10))|0x30);
;     328 //       
;     329 //       if(value>99){ lcd_data(mmlb,1);lcd_data(mb,1);lcd_data(lb,1); }
;     330 //       else if (value >9){lcd_data(mb,1);lcd_data(lb,1); }
;     331 //       else 
;     332 //       {   
;     333 //       lcd_data(0x30,1);
;     334 //       lcd_data(lb,1); 
;     335 //       }
;     336 // }                       
;     337 
;     338 

_itoa:
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret
__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
_rtc_init:
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	STD  Y+2,R30
	LDD  R30,Y+1
	CPI  R30,0
	BRNE PC+2
	RJMP _0x11
	LDD  R30,Y+2
	ORI  R30,0x10
	STD  Y+2,R30
_0x11:
	LD   R30,Y
	CPI  R30,0
	BRNE PC+2
	RJMP _0x12
	LDD  R30,Y+2
	ORI  R30,0x80
	STD  Y+2,R30
_0x12:
	RCALL SUBOPT_0xF
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x10
	LDD  R30,Y+2
	RCALL SUBOPT_0x10
	RCALL _i2c_stop
	ADIW R28,3
	RET
_rtc_get_time:
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0x0
	RCALL _i2c_write
	RCALL _i2c_start
	LDI  R30,LOW(209)
	RCALL SUBOPT_0x10
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0xD
	ST   X,R30
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	RCALL _i2c_stop
	ADIW R28,6
	RET
_rtc_get_date:
	RCALL SUBOPT_0xF
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x10
	RCALL _i2c_start
	LDI  R30,LOW(209)
	RCALL SUBOPT_0x10
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x11
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X,R30
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0xD
	ST   X,R30
	RCALL _i2c_stop
	ADIW R28,6
	RET
_spi:
	LD   R30,Y
	OUT  0x2E,R30
_0x13:
	IN   R30,0x2D
	SBRC R30,7
	RJMP _0x15
	RJMP _0x13
_0x15:
	IN   R30,0x2E
	ADIW R28,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 30 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x1:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(128)
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x3:
	LDI  R31,0
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	RCALL SUBOPT_0x1
	RJMP _itoa

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5:
	RCALL SUBOPT_0x1
	RJMP _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	ST   -Y,R30
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x7:
	ST   -Y,R30
	RJMP _lcd_cmd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	RCALL SUBOPT_0x1
	RCALL _delay_ms
	LDI  R30,LOW(3)
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	__DELAY_USB 213
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL SUBOPT_0x1
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x1
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0xC:
	CBI  0x5,1
	SBI  0x5,2
	IN   R30,0xB
	ANDI R30,LOW(0xF)
	OUT  0xB,R30
	IN   R30,0xB
	OR   R30,R17
	OUT  0xB,R30
	__DELAY_USB 7
	CBI  0x5,2
	__DELAY_USB 7
	SBI  0x5,2
	IN   R30,0xB
	ANDI R30,LOW(0xF)
	OUT  0xB,R30
	IN   R30,0xB
	OR   R30,R16
	OUT  0xB,R30
	__DELAY_USB 7
	CBI  0x5,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	LD   R26,Y
	LDD  R27,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xF:
	RCALL _i2c_start
	LDI  R30,LOW(208)
	ST   -Y,R30
	RJMP _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	ST   -Y,R30
	RJMP _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x11:
	RCALL _i2c_read
	ST   -Y,R30
	RJMP _bcd2bin

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	RJMP SUBOPT_0x0

	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2
_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,7
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,13
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	ld   r23,y+
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ld   r30,y+
	ldi  r23,8
__i2c_write0:
	lsl  r30
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x3E8
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

_bcd2bin:
	ld   r30,y
	swap r30
	andi r30,0xf
	mov  r26,r30
	lsl  r26
	lsl  r26
	add  r30,r26
	lsl  r30
	ld   r26,y+
	andi r26,0xf
	add  r30,r26
	ret

_bin2bcd:
	ld   r26,y+
	clr  r30
__bin2bcd0:
	subi r26,10
	brmi __bin2bcd1
	subi r30,-16
	rjmp __bin2bcd0
__bin2bcd1:
	subi r26,-10
	add  r30,r26
	ret

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD R26,R28
	ADC R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
