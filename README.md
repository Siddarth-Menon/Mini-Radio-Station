# Mini-Radio-Station

## Softwares used:

1. Code Vision AVR
2. AVR Studio
3. Real Term

## Hardware used:

1. ATMega32 MCU
2. ATMega48 MCU
3. 16x2 LCD
4. NRF24L01 2.4GHZ Transceivers
5. RTC Module
6. DB9 connector

## Working:

Here 2 NRF24L01 Transceivers are connected to the two microcontrollers, ATMega32 and ATMega48 (1 each) using SPI protocol. The MCUs are configured as the master device
and the NRF24L01 modules are configured as the slave device. The ATMega32 is at the transmitter end (transmitting station) and the ATMega48 is at the receiver end (receiving station). A 16x2 LCD is connected to the ATMega48 MCU for displaying the recieved messages. RTC module is also connected to the ATMega48 MCU using I2C protocol for displaying the date and time on the LCD. The SPI folder consits of files which are to be flashed to the ATMega32 MCU and the SPI2 folder consists of files which are to be flashed to the ATMega48 MCU. The DB9 connector is connected from the PC to the ATMega32 MCU for sending messages to the MCU via UART.

- The 16x2 LCD connected to the ATMega48 MCU displays date and time when no message is received by the receiver station.
- To send a message, the message is entered in the send field of the Real Term softwrare with a '$' symbol in the beginning.
- When the send ASCII button is clicked, the data is sent to the ATMega32 via DB9 port by UART protocol.
- The data is then sent to the NRF module 1, this data is then sent wirelessly to the NRF module 2. (RF communication)
- The NRF module 2 then sends the recieved data to the ATMega48 MCU.
- The LCD is then cleared and the recieved data is then displayed on the it.

## Application:

Can be used for private communication between two persons or organizations by adjusting the frequency and encrypting the data by using certain algorithms.

