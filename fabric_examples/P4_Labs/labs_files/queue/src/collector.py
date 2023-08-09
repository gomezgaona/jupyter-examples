from scapy.all import *
import atexit
import sys

class QueueOccupancy(Packet):
        name = "queueOccupancy"
        fields_desc = [BitField("queue_occupancy", 0, 48)]

global prev
prev = -1
def packet_sniffer(packet):
        global prev
        #print(hex(packet[IPv4].))
        if packet.haslayer(QueueOccupancy):
                queue_header = packet[QueueOccupancy]

                queue_occupancy = queue_header.queue_occupancy
                print(queue_occupancy)
                #rate_of_increase = queue_occupancy - prev
                #print("The queue_occupancy is: ",queue_occupancy)
                #if(prev> -1 and rate_of_increase > -1):
                #with open('queue_occupancy_values.txt', 'a') as file:
                #       file.write(str(rate_of_increase) + '\n')
                #prev = queue_occupancy

bind_layers(IP,QueueOccupancy,proto=0x99)

sniff(iface="ens7", prn=packet_sniffer)