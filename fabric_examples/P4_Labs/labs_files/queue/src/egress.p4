/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/
#define PKT_INSTANCE_TYPE_EGRESS_CLONE 2

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
   apply {
       if(standard_metadata.instance_type != PKT_INSTANCE_TYPE_EGRESS_CLONE){
           clone_preserving_field_list(CloneType.E2E, 8, 0);
       }
       else{
            //hdr.ipv4.setInvalid();
            hdr.tcp.setInvalid();
            hdr.queue.setValid();
            hdr.queue.queue = (bit<48>)standard_metadata.deq_timedelta;
            hdr.ethernet.srcAddr = 0x4;
            hdr.ethernet.dstAddr = 0x6;
            hdr.ipv4.srcAddr = 0xc0a80301; // 192.168.3.1
            hdr.ipv4.dstAddr = 0xc0a8030a; // 192.168.3.10
            hdr.ipv4.protocol = 0x99;
            hdr.ipv4.totalLen = 40;
            truncate((bit<32>)40);
            
            //hdr.ethernet.etherType = 0X1234;
       }
   }    

}
