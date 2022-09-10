# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash-0.7.6
	aho-corasick-0.7.18
	ansi_term-0.12.1
	atty-0.2.14
	autocfg-1.1.0
	bitflags-1.3.2
	bstr-0.2.17
	cc-1.0.73
	cfg-if-1.0.0
	chrono-0.4.19
	clap-2.34.0
	csv-1.1.6
	csv-core-0.1.10
	directories-next-2.0.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	either-1.7.0
	fallible-iterator-0.2.0
	fallible-streaming-iterator-0.1.9
	getrandom-0.2.7
	hashbrown-0.12.2
	hashlink-0.8.0
	hermit-abi-0.1.19
	humantime-2.1.0
	itertools-0.10.3
	itoa-0.4.8
	lazy_static-1.4.0
	libc-0.2.126
	libsqlite3-sys-0.25.0
	memchr-2.5.0
	num-integer-0.1.45
	num-traits-0.2.15
	numtoa-0.1.0
	once_cell-1.13.0
	pkg-config-0.3.25
	ppv-lite86-0.2.16
	proc-macro2-1.0.40
	quote-1.0.20
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.3
	redox_syscall-0.2.13
	redox_termios-0.1.2
	redox_users-0.4.3
	regex-1.6.0
	regex-automata-0.1.10
	regex-syntax-0.6.27
	relative-path-1.7.2
	rusqlite-0.28.0
	ryu-1.0.10
	serde-1.0.139
	shellexpand-2.1.0
	smallvec-1.9.0
	strsim-0.8.0
	syn-1.0.98
	termion-1.5.6
	textwrap-0.11.0
	thiserror-1.0.31
	thiserror-impl-1.0.31
	time-0.1.44
	unicode-ident-1.0.2
	unicode-segmentation-1.9.0
	unicode-width-0.1.9
	vcpkg-0.2.15
	vec_map-0.8.2
	version_check-0.9.4
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo readme.gentoo-r1

DESCRIPTION="Context-aware bash history search replacement (ctrl-r)"
HOMEPAGE="https://github.com/cantino/mcfly"
SRC_URI="https://github.com/cantino/mcfly/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)"

LICENSE="
	MIT Unicode-DFS-2016
	|| ( MIT Apache-2.0 )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 Boost-1.0 )
	|| ( MIT Unlicense )
"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	cargo_src_install

	insinto /usr/share/${PN}
	doins ${PN}.{bash,fish,zsh}

	# create README.gentoo
	local DISABLE_AUTOFORMATTING="yes"
	local DOC_CONTENTS=\
"To start using ${PN}, add the following to your shell:

~/.bashrc
eval \"\$(mcfly init bash)\"

~/.config/fish/config.fish
mcfly init fish | source

~/.zsh
eval \"\$(mcfly init zsh)\""
	readme.gentoo_create_doc

	einstalldocs
}

pkg_postinst() {
	readme.gentoo_print_elog
}
