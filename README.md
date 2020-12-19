# VGA_Ambilight
The final project of RTR710 @2020/2021

![GitHub](https://img.shields.io/github/license/clockfix/VGA_Ambilight?style=plastic) 
![GitHub last commit](https://img.shields.io/github/last-commit/clockfix/VGA_Ambilight?style=plastic)
![GitHub language count](https://img.shields.io/github/languages/count/clockfix/VGA_Ambilight?style=plastic)
![GitHub top language](https://img.shields.io/github/languages/top/clockfix/VGA_Ambilight?style=plastic)
![GitHub repo size](https://img.shields.io/github/repo-size/clockfix/VGA_Ambilight?style=plastic)
![GitHub contributors](https://img.shields.io/github/contributors/Clockfix/VGA_Ambilight?style=plastic)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/Clockfix/VGA_Ambilight?style=plastic)


## Output module
Output module consists of 2-port RAM, FSM and bit_sender module. Top entity write in memory LED color value and set new_data "HIGH" to indicate that data in memory have changes and need to be transmitted again. If new_data is always "HIGH" then data will be transmitted continuously no mater what.
### ram2port
![ram2port MegaWizard](https://raw.githubusercontent.com/Clockfix/VGA_Ambilight/LED_controler/doc/ram-2port.png) 
### bit_sender.vhd
![result of test bench for bit_sender module](https://raw.githubusercontent.com/Clockfix/VGA_Ambilight/LED_controler/doc/bit_sender.png) 
### sender_fsm.vhd

