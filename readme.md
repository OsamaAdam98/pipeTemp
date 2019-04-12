# pipeTemp

pipeTemp is an application that monitors the temperature reported by an adc sensor. 

Here's a breif explanation of most of the modules and their inputs and outputs.

## clk

The clk is running at 10 MHz.

## uArt modules

The uArt consists of two modules, the tx (transmitter) and rx (receiver). 

The baudrate can be set by the user.

## controller module

The controller is the brain of the application, it receives the input from the adc and instructs the uArt to transmit the temperature every 15 mins.

## digiClock module

This is a simple digital clock that counts the seconds, minutes, hours, days and months of operation. it also signals the controller every minute.
