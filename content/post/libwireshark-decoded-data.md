+++
title = "Libwireshark Decoded Data Struct"
description = ""

tags = [
    "wireshark",
]
date = "2016-04-11"
categories = [
    "blog",
]
+++

When using libwireshark library decoding packet, the decoded data is stored in `struct epan_dissect`.
We can browse this struct to search or display packet data.

```c
struct epan_dissect {
	struct epan_session *session;
	tvbuff_t	*tvb;
	proto_tree	*tree;
	packet_info	pi;
};
```

`epan_dissect->tree` points to data struct tree.

```c
typedef proto_node proto_tree;
typedef struct _proto_node {
	struct _proto_node *first_child;
	struct _proto_node *last_child;
	struct _proto_node *next;
	struct _proto_node *parent;
	field_info  *finfo;
	tree_data_t *tree_data;
} proto_node;
```

```c
typedef struct field_info {
	header_field_info	*hfinfo; /**< pointer to registered field information */
	...
	fvalue_t		 value;
} field_info;
```

```c
typedef struct _header_field_info header_field_info;
struct _header_field_info {
	const char	*name;    /**< [FIELDNAME] full name of this field */
	const char	*abbrev;  /**< [FIELDABBREV] abbreviated name of this field */
	...
};
```

Every node of tree stores one information of packet.
The information includes name and value.
For example if we want to find IP source address, the name is `ip.src`, value is like `192.168.1.1`.

The name is stored in `epan_dissect->tree->finfo->hfinfo->abbrev`.

The value is stored in `epan_dissect->tree->finfo->value`.
We can use function `fvalue_to_string_repr` to convert value to display format.

```c
const char *name = node->finfo->hfinfo->abbrev;

fvalue_t fv = node->finfo->value;
char *value = fvalue_to_string_repr(&fv, FTREPR_DISPLAY, NULL);
```

After browsing the node of tree, we can print out the data of packet like this.

```sh
[ip]
. [ip.version] 4
. [ip.hdr_len] 20
. [ip.dsfield] 0
. . [ip.dsfield.dscp] 0
. . [ip.dsfield.ecn] 0
. [ip.len] 160
. [ip.id] 24538
. [ip.flags] 0
. . [ip.flags.rb] 0
. . [ip.flags.df] 0
. . [ip.flags.mf] 0
. [ip.frag_offset] 0
. [ip.ttl] 64
. [ip.proto] 132
. [ip.checksum] 15303
. . [ip.checksum_good] 0
. . [ip.checksum_bad] 0
. [ip.src] 10.128.228.50
. [ip.addr] 10.128.228.50
. [ip.src_host] 10.128.228.50
. [ip.host] 10.128.228.50
. [ip.dst] 10.128.229.6
. [ip.addr] 10.128.229.6
. [ip.dst_host] 10.128.229.6
. [ip.host] 10.128.229.6
```

You can get full source code from [https://github.com/sunwxg/libwireshark_decoded_data.git](https://github.com/sunwxg/libwireshark_decoded_data.git).
If you want know how libwireshark decodes packet, you can referece another blog [Use libwireshark decoding PCAP files](http://sunwxg.github.io/post/use-libwireshark-decode-packet/)
