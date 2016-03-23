+++
title = "Use libwireshark decoding PACP files"
description = "Use libwireshark library to decode PACP file in C code."

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

```C
	epan_dissect_t *edt;

	/* all the decoded data store in struct edt */
	read_packet(&edt);
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

My source code is on **[github](https://github.com/sunwxg/decode_by_libwireshark)**. You can follow the guide to run and debug.
