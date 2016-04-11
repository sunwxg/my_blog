+++
title = "Use libwireshark decoding PCAP files"
description = "Use libwireshark library to decode PCAP file in C code."

tags = [
    "wireshark",
]
date = "2016-03-23"
categories = [
    "blog",
]
+++

We use Wireshark tool to decode IP packet and analyse signaling. If we want to write our own tool to decode packet, we can use libwireshark library.

First do some initial work.

```C
init_process_policies();

epan_init(register_all_protocols, register_all_protocol_handoffs, NULL, NULL);

/* cfile is a global varible */
cap_file_init(&cfile);
cfile.filename = filename;

cfile.count = 0;
cfile.epan = epan_new();
cfile.epan->data = &cfile;
cfile.epan->get_frame_ts = tshark_get_frame_ts;
```

Second read and decode packet.

Function ` wtap_read` read one packet from file.

Function `epan_dissect_new` create a new `struct epan_dissect_t`.

Function `epan_dissect_run` decode packet.

```C
if (wtap_read(cfile.wth, &err, &err_info, &data_offset)) {

	cfile.count++;

	frame_data fdlocal;
	frame_data_init(&fdlocal, cfile.count, whdr, data_offset, cum_bytes);

	edt = epan_dissect_new(cfile.epan, TRUE, TRUE);

	frame_data_set_before_dissect(&fdlocal, &cfile.elapsed_time, &cfile.ref, cfile.prev_dis);
	cfile.ref = &fdlocal;

	epan_dissect_run(edt, cfile.cd_t, &(cfile.phdr), frame_tvbuff_new(&fdlocal, buf), &fdlocal, &cfile.cinfo);

	frame_data_set_after_dissect(&fdlocal, &cum_bytes);
	cfile.prev_cap = cfile.prev_dis = frame_data_sequence_add(cfile.frames, &fdlocal);

	//free space
	frame_data_destroy(&fdlocal);

	*edt_r = edt;
	return TRUE;
}
return FALSE;
```

Print out packet.

```C
/* print out as XML format */
proto_tree_write_pdml(edt, stdout);

/* print out as TEXT format */
proto_tree_print(&print_args, edt, print_stream);
```

Release memory.

```C
epan_dissect_free(edt);
edt = NULL;

free_frame_data_sequence(cfile.frames);
cfile.frames = NULL;

wtap_close(cfile.wth);
cfile.wth = NULL;

epan_free(cfile.epan);

epan_cleanup();
```

My source code is on [github](https://github.com/sunwxg/decode_by_libwireshark). You can follow the guide to run and debug.
