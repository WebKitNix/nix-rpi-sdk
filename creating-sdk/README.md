
## Generating Toolchain ##

All needed files are inside the repository:

<pre>
cd nix-rpi-sdk/creating-sdk/toolchain
./build.sh
</pre>

After the process finishes, you will get a tarball (toolchain-chroot-x86_64.tar.bz2) with the following content:

<pre>
./
./usr/
./usr/lib/
./usr/lib/gcc/
./usr/lib/gcc/arm-linux-gnueabihf/
./usr/lib/gcc/arm-linux-gnueabihf/4.6/
./usr/lib/gcc/arm-linux-gnueabihf/4.6/cc1plus
./usr/lib/gcc/arm-linux-gnueabihf/4.6/collect2
./usr/lib/gcc/arm-linux-gnueabihf/4.6/cc1
./usr/lib/gcc/arm-linux-gnueabihf/4.6/liblto_plugin.so.0.0.0
./usr/lib/gcc/arm-linux-gnueabihf/4.6/lto1
./usr/lib/gcc/arm-linux-gnueabihf/4.6/lto-wrapper
./usr/bin/
./usr/bin/ld.bfd
./usr/bin/ld.gold
./usr/bin/g++-4.6
./usr/bin/size
./usr/bin/ar
./usr/bin/gprof
./usr/bin/readelf
./usr/bin/gcov-4.6
./usr/bin/nm
./usr/bin/strip
./usr/bin/elfedit
./usr/bin/c++filt
./usr/bin/arm-linux-gnueabihf-g++-4.6
./usr/bin/objdump
./usr/bin/ranlib
./usr/bin/gcc-4.6
./usr/bin/as
./usr/bin/objcopy
./usr/bin/cpp-4.6
./usr/bin/arm-linux-gnueabihf-gcc-4.6
./usr/bin/addr2line
./usr/bin/strings
./lib/
./lib/x86_64-linux-gnu/
./lib/x86_64-linux-gnu/libopcodes-2.22.so
./lib/x86_64-linux-gnu/libbfd-2.22.so
</pre>

##Generating Native Tools##

<pre>
mkdir native-tools
cd native-tools
#Download the required packages
apt-get download libnet-ssleay-perl liblocale-gettext-perl libhtml-parser-perl libtext-iconv-perl libtext-charwidth-perl libsocket-perl libxml-parser-perl perl-base perl sed coreutils m4 cmake make bash dash git libc6 icecc
#Extract packages
for i in `ls *.deb`; do dpkg -x $i .; done
#Remove uname: we MUST NOT replace uname.
rm bin/uname
#Then add all the libraries required by the installed binaries
#Remove the unneeded files (for example, doc and scripts)
#Create the tarball
tar --owner=root --group=root -cjf ../native-tools-x86_64.tar.bz2
</pre>

The tarball must have the following contents:
<pre>
user@machine:~$ tar tf native-tools-x86_64.tar.bz2
./
./usr/
./usr/bin/
./usr/bin/make
./usr/bin/whoami
./usr/bin/expr
./usr/bin/comm
./usr/bin/sort
./usr/bin/head
./usr/bin/sha512sum
./usr/bin/logname
./usr/bin/m4
./usr/bin/nice
./usr/bin/test
./usr/bin/wc
./usr/bin/cpack
./usr/bin/dirname
./usr/bin/pinky
./usr/bin/ctest
./usr/bin/who
./usr/bin/groups
./usr/bin/seq
./usr/bin/sum
./usr/bin/nohup
./usr/bin/users
./usr/bin/nproc
./usr/bin/runcon
./usr/bin/paste
./usr/bin/printenv
./usr/bin/unexpand
./usr/bin/a2p
./usr/bin/expand
./usr/bin/chcon
./usr/bin/git-upload-pack
./usr/bin/du
./usr/bin/split
./usr/bin/perl
./usr/bin/cmake
./usr/bin/pr
./usr/bin/tac
./usr/bin/od
./usr/bin/install
./usr/bin/clear_console
./usr/bin/tee
./usr/bin/sha256sum
./usr/bin/shuf
./usr/bin/id
./usr/bin/mkfifo
./usr/bin/tty
./usr/bin/touch
./usr/bin/uniq
./usr/bin/link
./usr/bin/env
./usr/bin/truncate
./usr/bin/sha224sum
./usr/bin/tr
./usr/bin/yes
./usr/bin/arch
./usr/bin/[
./usr/bin/join
./usr/bin/base64
./usr/bin/hostid
./usr/bin/fmt
./usr/bin/sha1sum
./usr/bin/ptx
./usr/bin/pathchk
./usr/bin/shred
./usr/bin/factor
./usr/bin/md5sum
./usr/bin/stdbuf
./usr/bin/timeout
./usr/bin/md5sum.textutils
./usr/bin/cut
./usr/bin/nl
./usr/bin/csplit
./usr/bin/unlink
./usr/bin/git-shell
./usr/bin/icecc
./usr/bin/tail
./usr/bin/stat
./usr/bin/printf
./usr/bin/qemu-arm-static
./usr/bin/sha384sum
./usr/bin/fold
./usr/bin/dircolors
./usr/bin/cksum
./usr/bin/tsort
./usr/bin/basename
./usr/bin/perl5.14.2
./usr/bin/git
./usr/sbin/
./usr/sbin/iceccd
./usr/sbin/chroot
./usr/sbin/icecc-scheduler
./usr/lib/
./usr/lib/git-core/
./usr/lib/git-core/git-http-fetch
./usr/lib/git-core/git-upload-pack
./usr/lib/git-core/git-remote-http
./usr/lib/git-core/git-daemon
./usr/lib/git-core/git-show-index
./usr/lib/git-core/git-credential-cache--daemon
./usr/lib/git-core/git-imap-send
./usr/lib/git-core/git-sh-i18n--envsubst
./usr/lib/git-core/git-credential-cache
./usr/lib/git-core/git-http-push
./usr/lib/git-core/git-shell
./usr/lib/git-core/git-fast-import
./usr/lib/git-core/git-credential-store
./usr/lib/git-core/git-http-backend
./usr/lib/git-core/git
./usr/lib/perl/
./usr/lib/perl/5.14.2/
./usr/lib/perl/5.14.2/auto/
./usr/lib/perl/5.14.2/auto/Filter/
./usr/lib/perl/5.14.2/auto/Filter/Util/
./usr/lib/perl/5.14.2/auto/Filter/Util/Call/
./usr/lib/perl/5.14.2/auto/Filter/Util/Call/Call.so
./usr/lib/perl/5.14.2/auto/Storable/
./usr/lib/perl/5.14.2/auto/Storable/Storable.so
./usr/lib/perl/5.14.2/auto/IO/
./usr/lib/perl/5.14.2/auto/IO/IO.so
./usr/lib/perl/5.14.2/auto/Math/
./usr/lib/perl/5.14.2/auto/Math/BigInt/
./usr/lib/perl/5.14.2/auto/Math/BigInt/FastCalc/
./usr/lib/perl/5.14.2/auto/Math/BigInt/FastCalc/FastCalc.so
./usr/lib/perl/5.14.2/auto/Encode/
./usr/lib/perl/5.14.2/auto/Encode/CN/
./usr/lib/perl/5.14.2/auto/Encode/CN/CN.so
./usr/lib/perl/5.14.2/auto/Encode/Encode.so
./usr/lib/perl/5.14.2/auto/Encode/JP/
./usr/lib/perl/5.14.2/auto/Encode/JP/JP.so
./usr/lib/perl/5.14.2/auto/Encode/Unicode/
./usr/lib/perl/5.14.2/auto/Encode/Unicode/Unicode.so
./usr/lib/perl/5.14.2/auto/Encode/KR/
./usr/lib/perl/5.14.2/auto/Encode/KR/KR.so
./usr/lib/perl/5.14.2/auto/Encode/Symbol/
./usr/lib/perl/5.14.2/auto/Encode/Symbol/Symbol.so
./usr/lib/perl/5.14.2/auto/Encode/TW/
./usr/lib/perl/5.14.2/auto/Encode/TW/TW.so
./usr/lib/perl/5.14.2/auto/Encode/EBCDIC/
./usr/lib/perl/5.14.2/auto/Encode/EBCDIC/EBCDIC.so
./usr/lib/perl/5.14.2/auto/Encode/Byte/
./usr/lib/perl/5.14.2/auto/Encode/Byte/Byte.so
./usr/lib/perl/5.14.2/auto/Data/
./usr/lib/perl/5.14.2/auto/Data/Dumper/
./usr/lib/perl/5.14.2/auto/Data/Dumper/Dumper.so
./usr/lib/perl/5.14.2/auto/Text/
./usr/lib/perl/5.14.2/auto/Text/Soundex/
./usr/lib/perl/5.14.2/auto/Text/Soundex/Soundex.so
./usr/lib/perl/5.14.2/auto/Compress/
./usr/lib/perl/5.14.2/auto/Compress/Raw/
./usr/lib/perl/5.14.2/auto/Compress/Raw/Bzip2/
./usr/lib/perl/5.14.2/auto/Compress/Raw/Bzip2/Bzip2.so
./usr/lib/perl/5.14.2/auto/Compress/Raw/Zlib/
./usr/lib/perl/5.14.2/auto/Compress/Raw/Zlib/Zlib.so
./usr/lib/perl/5.14.2/auto/re/
./usr/lib/perl/5.14.2/auto/re/re.so
./usr/lib/perl/5.14.2/auto/DB_File/
./usr/lib/perl/5.14.2/auto/DB_File/DB_File.so
./usr/lib/perl/5.14.2/auto/I18N/
./usr/lib/perl/5.14.2/auto/I18N/Langinfo/
./usr/lib/perl/5.14.2/auto/I18N/Langinfo/Langinfo.so
./usr/lib/perl/5.14.2/auto/Hash/
./usr/lib/perl/5.14.2/auto/Hash/Util/
./usr/lib/perl/5.14.2/auto/Hash/Util/Util.so
./usr/lib/perl/5.14.2/auto/Hash/Util/FieldHash/
./usr/lib/perl/5.14.2/auto/Hash/Util/FieldHash/FieldHash.so
./usr/lib/perl/5.14.2/auto/IPC/
./usr/lib/perl/5.14.2/auto/IPC/SysV/
./usr/lib/perl/5.14.2/auto/IPC/SysV/SysV.so
./usr/lib/perl/5.14.2/auto/Digest/
./usr/lib/perl/5.14.2/auto/Digest/SHA/
./usr/lib/perl/5.14.2/auto/Digest/SHA/SHA.so
./usr/lib/perl/5.14.2/auto/Digest/MD5/
./usr/lib/perl/5.14.2/auto/Digest/MD5/MD5.so
./usr/lib/perl/5.14.2/auto/Opcode/
./usr/lib/perl/5.14.2/auto/Opcode/Opcode.so
./usr/lib/perl/5.14.2/auto/MIME/
./usr/lib/perl/5.14.2/auto/MIME/Base64/
./usr/lib/perl/5.14.2/auto/MIME/Base64/Base64.so
./usr/lib/perl/5.14.2/auto/Socket/
./usr/lib/perl/5.14.2/auto/Socket/Socket.so
./usr/lib/perl/5.14.2/auto/GDBM_File/
./usr/lib/perl/5.14.2/auto/GDBM_File/GDBM_File.so
./usr/lib/perl/5.14.2/auto/Unicode/
./usr/lib/perl/5.14.2/auto/Unicode/Collate/
./usr/lib/perl/5.14.2/auto/Unicode/Collate/Collate.so
./usr/lib/perl/5.14.2/auto/Unicode/Normalize/
./usr/lib/perl/5.14.2/auto/Unicode/Normalize/Normalize.so
./usr/lib/perl/5.14.2/auto/mro/
./usr/lib/perl/5.14.2/auto/mro/mro.so
./usr/lib/perl/5.14.2/auto/B/
./usr/lib/perl/5.14.2/auto/B/B.so
./usr/lib/perl/5.14.2/auto/ODBM_File/
./usr/lib/perl/5.14.2/auto/ODBM_File/ODBM_File.so
./usr/lib/perl/5.14.2/auto/Cwd/
./usr/lib/perl/5.14.2/auto/Cwd/Cwd.so
./usr/lib/perl/5.14.2/auto/threads/
./usr/lib/perl/5.14.2/auto/threads/shared/
./usr/lib/perl/5.14.2/auto/threads/shared/shared.so
./usr/lib/perl/5.14.2/auto/threads/threads.so
./usr/lib/perl/5.14.2/auto/List/
./usr/lib/perl/5.14.2/auto/List/Util/
./usr/lib/perl/5.14.2/auto/List/Util/Util.so
./usr/lib/perl/5.14.2/auto/POSIX/
./usr/lib/perl/5.14.2/auto/POSIX/POSIX.so
./usr/lib/perl/5.14.2/auto/PerlIO/
./usr/lib/perl/5.14.2/auto/PerlIO/encoding/
./usr/lib/perl/5.14.2/auto/PerlIO/encoding/encoding.so
./usr/lib/perl/5.14.2/auto/PerlIO/via/
./usr/lib/perl/5.14.2/auto/PerlIO/via/via.so
./usr/lib/perl/5.14.2/auto/PerlIO/scalar/
./usr/lib/perl/5.14.2/auto/PerlIO/scalar/scalar.so
./usr/lib/perl/5.14.2/auto/File/
./usr/lib/perl/5.14.2/auto/File/Glob/
./usr/lib/perl/5.14.2/auto/File/Glob/Glob.so
./usr/lib/perl/5.14.2/auto/NDBM_File/
./usr/lib/perl/5.14.2/auto/NDBM_File/NDBM_File.so
./usr/lib/perl/5.14.2/auto/Fcntl/
./usr/lib/perl/5.14.2/auto/Fcntl/Fcntl.so
./usr/lib/perl/5.14.2/auto/Time/
./usr/lib/perl/5.14.2/auto/Time/Piece/
./usr/lib/perl/5.14.2/auto/Time/Piece/Piece.so
./usr/lib/perl/5.14.2/auto/Time/HiRes/
./usr/lib/perl/5.14.2/auto/Time/HiRes/HiRes.so
./usr/lib/perl/5.14.2/auto/SDBM_File/
./usr/lib/perl/5.14.2/auto/SDBM_File/SDBM_File.so
./usr/lib/perl/5.14.2/auto/Sys/
./usr/lib/perl/5.14.2/auto/Sys/Syslog/
./usr/lib/perl/5.14.2/auto/Sys/Syslog/Syslog.so
./usr/lib/perl/5.14.2/auto/Sys/Hostname/
./usr/lib/perl/5.14.2/auto/Sys/Hostname/Hostname.so
./usr/lib/perl/5.14.2/auto/Tie/
./usr/lib/perl/5.14.2/auto/Tie/Hash/
./usr/lib/perl/5.14.2/auto/Tie/Hash/NamedCapture/
./usr/lib/perl/5.14.2/auto/Tie/Hash/NamedCapture/NamedCapture.so
./usr/lib/perl/5.14.2/auto/Devel/
./usr/lib/perl/5.14.2/auto/Devel/PPPort/
./usr/lib/perl/5.14.2/auto/Devel/PPPort/PPPort.so
./usr/lib/perl/5.14.2/auto/Devel/Peek/
./usr/lib/perl/5.14.2/auto/Devel/Peek/Peek.so
./usr/lib/perl/5.14.2/auto/Devel/DProf/
./usr/lib/perl/5.14.2/auto/Devel/DProf/DProf.so
./usr/lib/perl/5.14.2/auto/attributes/
./usr/lib/perl/5.14.2/auto/attributes/attributes.so
./usr/lib/coreutils/
./usr/lib/coreutils/libstdbuf.so
./usr/lib/x86_64-linux-gnu/
./usr/lib/x86_64-linux-gnu/libhx509.so.5
./usr/lib/x86_64-linux-gnu/libxmlrpc.so.3
./usr/lib/x86_64-linux-gnu/libhcrypto.so.4
./usr/lib/x86_64-linux-gnu/libp11-kit.so.0
./usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4
./usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0.3400.1
./usr/lib/x86_64-linux-gnu/libidn.so.11
./usr/lib/x86_64-linux-gnu/libkrb5support.so.0
./usr/lib/x86_64-linux-gnu/libsqlite3.so.0
./usr/lib/x86_64-linux-gnu/libsasl2.so.2
./usr/lib/x86_64-linux-gnu/libgnutls.so.26.21.8
./usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0.3400.1
./usr/lib/x86_64-linux-gnu/libkrb5support.so.0.1
./usr/lib/x86_64-linux-gnu/libcurl.so.4.2.0
./usr/lib/x86_64-linux-gnu/libp11-kit.so.0.0.0
./usr/lib/x86_64-linux-gnu/libxmlrpc_server.so.3
./usr/lib/x86_64-linux-gnu/libkrb5.so.26
./usr/lib/x86_64-linux-gnu/libkrb5.so.26.0.0
./usr/lib/x86_64-linux-gnu/libxml2.so.2
./usr/lib/x86_64-linux-gnu/libkrb5.so.3
./usr/lib/x86_64-linux-gnu/libtasn1.so.3
./usr/lib/x86_64-linux-gnu/libxml2.so.2.8.0
./usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.17
./usr/lib/x86_64-linux-gnu/libpcreposix.so.3
./usr/lib/x86_64-linux-gnu/libgthread-2.0.so.0
./usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2
./usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.3
./usr/lib/x86_64-linux-gnu/libxmlrpc_server_abyss.so.3
./usr/lib/x86_64-linux-gnu/libxmlrpc_xmlparse.so.3
./usr/lib/x86_64-linux-gnu/libxmlrpc_xmltok.so.3.16
./usr/lib/x86_64-linux-gnu/libarchive.so.12.0.4
./usr/lib/x86_64-linux-gnu/libhx509.so.5.0.0
./usr/lib/x86_64-linux-gnu/libhcrypto.so.4.1.0
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libaep.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libatalla.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libgmp.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/lib4758cca.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libsureware.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libchil.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libcapi.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libgost.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libpadlock.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libubsec.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libcswift.so
./usr/lib/x86_64-linux-gnu/openssl-1.0.0/engines/libnuron.so
./usr/lib/x86_64-linux-gnu/liblber-2.4.so.2.8.3
./usr/lib/x86_64-linux-gnu/libkrb5.so.3.3
./usr/lib/x86_64-linux-gnu/libstdc++.so.6
./usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4.2.0
./usr/lib/x86_64-linux-gnu/liblber-2.4.so.2
./usr/lib/x86_64-linux-gnu/libgnutls-extra.so.26.21.8
./usr/lib/x86_64-linux-gnu/libxmlrpc_util.so.3
./usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0
./usr/lib/x86_64-linux-gnu/libcurl.so.4
./usr/lib/x86_64-linux-gnu/libnettle.so.4.3
./usr/lib/x86_64-linux-gnu/libxmlrpc_server_abyss.so.3.16
./usr/lib/x86_64-linux-gnu/libxmlrpc_abyss.so.3.16
./usr/lib/x86_64-linux-gnu/libxmlrpc.so.3.16
./usr/lib/x86_64-linux-gnu/libasn1.so.8
./usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2
./usr/lib/x86_64-linux-gnu/libasn1.so.8.0.0
./usr/lib/x86_64-linux-gnu/libk5crypto.so.3
./usr/lib/x86_64-linux-gnu/libxmlrpc_server.so.3.16
./usr/lib/x86_64-linux-gnu/libgnutls.so.26
./usr/lib/x86_64-linux-gnu/libnettle.so.4
./usr/lib/x86_64-linux-gnu/libtic.so.5
./usr/lib/x86_64-linux-gnu/libgnutls-extra.so.26
./usr/lib/x86_64-linux-gnu/libwind.so.0
./usr/lib/x86_64-linux-gnu/libarchive.so.12
./usr/lib/x86_64-linux-gnu/glib-2.0/
./usr/lib/x86_64-linux-gnu/glib-2.0/glib-compile-schemas
./usr/lib/x86_64-linux-gnu/glib-2.0/gio-querymodules
./usr/lib/x86_64-linux-gnu/glib-2.0/glib-compile-resources
./usr/lib/x86_64-linux-gnu/libidn.so.11.6.8
./usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2.8.3
./usr/lib/x86_64-linux-gnu/libcurl.so.3
./usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2.2
./usr/lib/x86_64-linux-gnu/libgio-2.0.so.0.3400.1
./usr/lib/x86_64-linux-gnu/libheimntlm.so.0
./usr/lib/x86_64-linux-gnu/libxmlrpc_client.so.3
./usr/lib/x86_64-linux-gnu/libexpatw.so.1.6.0
./usr/lib/x86_64-linux-gnu/libroken.so.18
./usr/lib/x86_64-linux-gnu/libheimbase.so.1.0.0
./usr/lib/x86_64-linux-gnu/libgio-2.0.so.0
./usr/lib/x86_64-linux-gnu/libtasn1.so.3.1.16
./usr/lib/x86_64-linux-gnu/libxmlrpc_xmlparse.so.3.16
./usr/lib/x86_64-linux-gnu/sasl2/
./usr/lib/x86_64-linux-gnu/sasl2/libsasldb.so.2.0.25
./usr/lib/x86_64-linux-gnu/sasl2/libsasldb.so
./usr/lib/x86_64-linux-gnu/sasl2/libsasldb.so.2
./usr/lib/x86_64-linux-gnu/gconv/
./usr/lib/x86_64-linux-gnu/gconv/IBM901.so
./usr/lib/x86_64-linux-gnu/gconv/JOHAB.so
./usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache
./usr/lib/x86_64-linux-gnu/gconv/IBM9066.so
./usr/lib/x86_64-linux-gnu/gconv/IBM037.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-FI-SE.so
./usr/lib/x86_64-linux-gnu/gconv/CP772.so
./usr/lib/x86_64-linux-gnu/gconv/IBM852.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_6937-2.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-ES.so
./usr/lib/x86_64-linux-gnu/gconv/UTF-16.so
./usr/lib/x86_64-linux-gnu/gconv/KOI8-T.so
./usr/lib/x86_64-linux-gnu/gconv/TSCII.so
./usr/lib/x86_64-linux-gnu/gconv/ARMSCII-8.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1008_420.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1399.so
./usr/lib/x86_64-linux-gnu/gconv/IBM4899.so
./usr/lib/x86_64-linux-gnu/gconv/libJISX0213.so
./usr/lib/x86_64-linux-gnu/gconv/CP1257.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-15.so
./usr/lib/x86_64-linux-gnu/gconv/CP773.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_2033.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1390.so
./usr/lib/x86_64-linux-gnu/gconv/HP-ROMAN9.so
./usr/lib/x86_64-linux-gnu/gconv/BRF.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1112.so
./usr/lib/x86_64-linux-gnu/gconv/SJIS.so
./usr/lib/x86_64-linux-gnu/gconv/IBM280.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-14.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-16.so
./usr/lib/x86_64-linux-gnu/gconv/IBM943.so
./usr/lib/x86_64-linux-gnu/gconv/GBGBK.so
./usr/lib/x86_64-linux-gnu/gconv/libJIS.so
./usr/lib/x86_64-linux-gnu/gconv/LATIN-GREEK-1.so
./usr/lib/x86_64-linux-gnu/gconv/libISOIR165.so
./usr/lib/x86_64-linux-gnu/gconv/MAC-SAMI.so
./usr/lib/x86_64-linux-gnu/gconv/IBM860.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-5.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-3.so
./usr/lib/x86_64-linux-gnu/gconv/CP1252.so
./usr/lib/x86_64-linux-gnu/gconv/LATIN-GREEK.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_11548-1.so
./usr/lib/x86_64-linux-gnu/gconv/VISCII.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1153.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1156.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-6.so
./usr/lib/x86_64-linux-gnu/gconv/IBM904.so
./usr/lib/x86_64-linux-gnu/gconv/MACINTOSH.so
./usr/lib/x86_64-linux-gnu/gconv/INIS-CYRILLIC.so
./usr/lib/x86_64-linux-gnu/gconv/CP1125.so
./usr/lib/x86_64-linux-gnu/gconv/EUC-JISX0213.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-9.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-4.so
./usr/lib/x86_64-linux-gnu/gconv/IBM868.so
./usr/lib/x86_64-linux-gnu/gconv/UTF-7.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1146.so
./usr/lib/x86_64-linux-gnu/gconv/IBM866.so
./usr/lib/x86_64-linux-gnu/gconv/BIG5HKSCS.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-1.so
./usr/lib/x86_64-linux-gnu/gconv/INIS-8.so
./usr/lib/x86_64-linux-gnu/gconv/IBM274.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-2022-CN.so
./usr/lib/x86_64-linux-gnu/gconv/IBM277.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_5427.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-2022-JP.so
./usr/lib/x86_64-linux-gnu/gconv/IBM880.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-2022-CN-EXT.so
./usr/lib/x86_64-linux-gnu/gconv/CP1251.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1143.so
./usr/lib/x86_64-linux-gnu/gconv/CP10007.so
./usr/lib/x86_64-linux-gnu/gconv/IBM935.so
./usr/lib/x86_64-linux-gnu/gconv/IBM273.so
./usr/lib/x86_64-linux-gnu/gconv/IBM12712.so
./usr/lib/x86_64-linux-gnu/gconv/GBK.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1147.so
./usr/lib/x86_64-linux-gnu/gconv/IBM861.so
./usr/lib/x86_64-linux-gnu/gconv/SAMI-WS2.so
./usr/lib/x86_64-linux-gnu/gconv/IBM870.so
./usr/lib/x86_64-linux-gnu/gconv/IBM281.so
./usr/lib/x86_64-linux-gnu/gconv/IBM278.so
./usr/lib/x86_64-linux-gnu/gconv/IBM9030.so
./usr/lib/x86_64-linux-gnu/gconv/T.61.so
./usr/lib/x86_64-linux-gnu/gconv/IBM5347.so
./usr/lib/x86_64-linux-gnu/gconv/HP-THAI8.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1158.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-ES-S.so
./usr/lib/x86_64-linux-gnu/gconv/IBM905.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-2.so
./usr/lib/x86_64-linux-gnu/gconv/IBM918.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1097.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-IR-197.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-AT-DE-A.so
./usr/lib/x86_64-linux-gnu/gconv/GEORGIAN-PS.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1137.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1132.so
./usr/lib/x86_64-linux-gnu/gconv/KOI8-RU.so
./usr/lib/x86_64-linux-gnu/gconv/CP1258.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1160.so
./usr/lib/x86_64-linux-gnu/gconv/MAC-UK.so
./usr/lib/x86_64-linux-gnu/gconv/IBM922.so
./usr/lib/x86_64-linux-gnu/gconv/CWI.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1129.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_6937.so
./usr/lib/x86_64-linux-gnu/gconv/IBM865.so
./usr/lib/x86_64-linux-gnu/gconv/GBBIG5.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-9E.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-7.so
./usr/lib/x86_64-linux-gnu/gconv/ISIRI-3342.so
./usr/lib/x86_64-linux-gnu/gconv/NATS-SEFI.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1133.so
./usr/lib/x86_64-linux-gnu/gconv/MAC-CENTRALEUROPE.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-CA-FR.so
./usr/lib/x86_64-linux-gnu/gconv/IBM290.so
./usr/lib/x86_64-linux-gnu/gconv/GREEK-CCITT.so
./usr/lib/x86_64-linux-gnu/gconv/GEORGIAN-ACADEMY.so
./usr/lib/x86_64-linux-gnu/gconv/IBM038.so
./usr/lib/x86_64-linux-gnu/gconv/IBM869.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1155.so
./usr/lib/x86_64-linux-gnu/gconv/EUC-TW.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-IR-209.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1162.so
./usr/lib/x86_64-linux-gnu/gconv/CP1255.so
./usr/lib/x86_64-linux-gnu/gconv/IBM4971.so
./usr/lib/x86_64-linux-gnu/gconv/CP737.so
./usr/lib/x86_64-linux-gnu/gconv/IBM803.so
./usr/lib/x86_64-linux-gnu/gconv/IBM866NAV.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1046.so
./usr/lib/x86_64-linux-gnu/gconv/KOI8-U.so
./usr/lib/x86_64-linux-gnu/gconv/IBM856.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_5427-EXT.so
./usr/lib/x86_64-linux-gnu/gconv/GOST_19768-74.so
./usr/lib/x86_64-linux-gnu/gconv/CP770.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1141.so
./usr/lib/x86_64-linux-gnu/gconv/IBM424.so
./usr/lib/x86_64-linux-gnu/gconv/IBM256.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-FR.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-IT.so
./usr/lib/x86_64-linux-gnu/gconv/DEC-MCS.so
./usr/lib/x86_64-linux-gnu/gconv/CP1256.so
./usr/lib/x86_64-linux-gnu/gconv/IBM4909.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1364.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1145.so
./usr/lib/x86_64-linux-gnu/gconv/GB18030.so
./usr/lib/x86_64-linux-gnu/gconv/GREEK7.so
./usr/lib/x86_64-linux-gnu/gconv/IBM4517.so
./usr/lib/x86_64-linux-gnu/gconv/KOI8-R.so
./usr/lib/x86_64-linux-gnu/gconv/CP775.so
./usr/lib/x86_64-linux-gnu/gconv/libCNS.so
./usr/lib/x86_64-linux-gnu/gconv/IBM9448.so
./usr/lib/x86_64-linux-gnu/gconv/MAC-IS.so
./usr/lib/x86_64-linux-gnu/gconv/IBM932.so
./usr/lib/x86_64-linux-gnu/gconv/IBM500.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-IS-FRISS.so
./usr/lib/x86_64-linux-gnu/gconv/CP1253.so
./usr/lib/x86_64-linux-gnu/gconv/CP774.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-PT.so
./usr/lib/x86_64-linux-gnu/gconv/libKSC.so
./usr/lib/x86_64-linux-gnu/gconv/IBM420.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-11.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-UK.so
./usr/lib/x86_64-linux-gnu/gconv/HP-ROMAN8.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-10.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1371.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-8.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1157.so
./usr/lib/x86_64-linux-gnu/gconv/IBM855.so
./usr/lib/x86_64-linux-gnu/gconv/RK1048.so
./usr/lib/x86_64-linux-gnu/gconv/IBM285.so
./usr/lib/x86_64-linux-gnu/gconv/UNICODE.so
./usr/lib/x86_64-linux-gnu/gconv/IBM902.so
./usr/lib/x86_64-linux-gnu/gconv/IBM874.so
./usr/lib/x86_64-linux-gnu/gconv/HP-TURKISH8.so
./usr/lib/x86_64-linux-gnu/gconv/IBM862.so
./usr/lib/x86_64-linux-gnu/gconv/CP1250.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-US.so
./usr/lib/x86_64-linux-gnu/gconv/CP771.so
./usr/lib/x86_64-linux-gnu/gconv/INIS.so
./usr/lib/x86_64-linux-gnu/gconv/IBM437.so
./usr/lib/x86_64-linux-gnu/gconv/IBM937.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1164.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-ES-A.so
./usr/lib/x86_64-linux-gnu/gconv/IEC_P27-1.so
./usr/lib/x86_64-linux-gnu/gconv/IBM275.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1166.so
./usr/lib/x86_64-linux-gnu/gconv/HP-GREEK8.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-2022-JP-3.so
./usr/lib/x86_64-linux-gnu/gconv/UHC.so
./usr/lib/x86_64-linux-gnu/gconv/IBM921.so
./usr/lib/x86_64-linux-gnu/gconv/ISO-2022-KR.so
./usr/lib/x86_64-linux-gnu/gconv/TIS-620.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-DK-NO.so
./usr/lib/x86_64-linux-gnu/gconv/IBM16804.so
./usr/lib/x86_64-linux-gnu/gconv/EUC-KR.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1025.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1388.so
./usr/lib/x86_64-linux-gnu/gconv/BIG5.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1008.so
./usr/lib/x86_64-linux-gnu/gconv/IBM423.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1123.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1144.so
./usr/lib/x86_64-linux-gnu/gconv/IBM930.so
./usr/lib/x86_64-linux-gnu/gconv/IBM939.so
./usr/lib/x86_64-linux-gnu/gconv/ECMA-CYRILLIC.so
./usr/lib/x86_64-linux-gnu/gconv/libGB.so
./usr/lib/x86_64-linux-gnu/gconv/IBM891.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-FI-SE-A.so
./usr/lib/x86_64-linux-gnu/gconv/IBM284.so
./usr/lib/x86_64-linux-gnu/gconv/ANSI_X3.110.so
./usr/lib/x86_64-linux-gnu/gconv/SHIFT_JISX0213.so
./usr/lib/x86_64-linux-gnu/gconv/IBM863.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-AT-DE.so
./usr/lib/x86_64-linux-gnu/gconv/UTF-32.so
./usr/lib/x86_64-linux-gnu/gconv/CP1254.so
./usr/lib/x86_64-linux-gnu/gconv/IBM933.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1142.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1122.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_5428.so
./usr/lib/x86_64-linux-gnu/gconv/NATS-DANO.so
./usr/lib/x86_64-linux-gnu/gconv/IBM864.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1167.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1004.so
./usr/lib/x86_64-linux-gnu/gconv/ISO646.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1148.so
./usr/lib/x86_64-linux-gnu/gconv/EBCDIC-DK-NO-A.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1026.so
./usr/lib/x86_64-linux-gnu/gconv/IBM871.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1163.so
./usr/lib/x86_64-linux-gnu/gconv/GREEK7-OLD.so
./usr/lib/x86_64-linux-gnu/gconv/KOI-8.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1130.so
./usr/lib/x86_64-linux-gnu/gconv/IBM857.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1047.so
./usr/lib/x86_64-linux-gnu/gconv/IBM875.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1149.so
./usr/lib/x86_64-linux-gnu/gconv/EUC-JP.so
./usr/lib/x86_64-linux-gnu/gconv/ISO8859-13.so
./usr/lib/x86_64-linux-gnu/gconv/MIK.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1140.so
./usr/lib/x86_64-linux-gnu/gconv/IBM903.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1124.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1161.so
./usr/lib/x86_64-linux-gnu/gconv/CP932.so
./usr/lib/x86_64-linux-gnu/gconv/ASMO_449.so
./usr/lib/x86_64-linux-gnu/gconv/IBM297.so
./usr/lib/x86_64-linux-gnu/gconv/EUC-CN.so
./usr/lib/x86_64-linux-gnu/gconv/TCVN5712-1.so
./usr/lib/x86_64-linux-gnu/gconv/PT154.so
./usr/lib/x86_64-linux-gnu/gconv/IBM850.so
./usr/lib/x86_64-linux-gnu/gconv/IBM1154.so
./usr/lib/x86_64-linux-gnu/gconv/ISO_10367-BOX.so
./usr/lib/x86_64-linux-gnu/gconv/gconv-modules
./usr/lib/x86_64-linux-gnu/gconv/IBM851.so
./usr/lib/x86_64-linux-gnu/gconv/CSN_369103.so
./usr/lib/x86_64-linux-gnu/gconv/EUC-JP-MS.so
./usr/lib/x86_64-linux-gnu/libc/
./usr/lib/x86_64-linux-gnu/libc/memcpy-syslog-preload.so
./usr/lib/x86_64-linux-gnu/libc/memcpy-preload.so
./usr/lib/x86_64-linux-gnu/libheimbase.so.1
./usr/lib/x86_64-linux-gnu/libpcreposix.so.3.13.1
./usr/lib/x86_64-linux-gnu/libldap-2.4.so.2
./usr/lib/x86_64-linux-gnu/libxmlrpc_xmltok.so.3
./usr/lib/x86_64-linux-gnu/libwind.so.0.0.0
./usr/lib/x86_64-linux-gnu/libxmlrpc_client.so.3.16
./usr/lib/x86_64-linux-gnu/libgssapi.so.3
./usr/lib/x86_64-linux-gnu/libsqlite3.so.0.8.6
./usr/lib/x86_64-linux-gnu/libgmodule-2.0.so.0.3400.1
./usr/lib/x86_64-linux-gnu/libgssapi.so.3.0.0
./usr/lib/x86_64-linux-gnu/libxmlrpc_abyss.so.3
./usr/lib/x86_64-linux-gnu/libroken.so.18.1.0
./usr/lib/x86_64-linux-gnu/libxmlrpc_util.so.3.16
./usr/lib/x86_64-linux-gnu/libsasl2.so.2.0.25
./usr/lib/x86_64-linux-gnu/libexpatw.so.1
./usr/lib/x86_64-linux-gnu/libxmlrpc_server_cgi.so.3
./usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0
./usr/lib/x86_64-linux-gnu/libxmlrpc_server_cgi.so.3.16
./usr/lib/x86_64-linux-gnu/libtic.so.5.9
./usr/lib/x86_64-linux-gnu/libheimntlm.so.0.1.0
./usr/lib/x86_64-linux-gnu/libk5crypto.so.3.1
./usr/lib/x86_64-linux-gnu/librtmp.so.0
./usr/lib/perl5/
./usr/lib/perl5/auto/
./usr/lib/perl5/auto/Text/
./usr/lib/perl5/auto/Text/Iconv/
./usr/lib/perl5/auto/Text/Iconv/Iconv.so
./usr/lib/perl5/auto/Text/CharWidth/
./usr/lib/perl5/auto/Text/CharWidth/CharWidth.so
./usr/lib/perl5/auto/XML/
./usr/lib/perl5/auto/XML/Parser/
./usr/lib/perl5/auto/XML/Parser/Expat/
./usr/lib/perl5/auto/XML/Parser/Expat/Expat.so
./usr/lib/perl5/auto/Locale/
./usr/lib/perl5/auto/Locale/gettext/
./usr/lib/perl5/auto/Locale/gettext/gettext.so
./usr/lib/perl5/auto/Socket/
./usr/lib/perl5/auto/Socket/Socket.so
./usr/lib/perl5/auto/HTML/
./usr/lib/perl5/auto/HTML/Parser/
./usr/lib/perl5/auto/HTML/Parser/Parser.so
./usr/lib/perl5/auto/Net/
./usr/lib/perl5/auto/Net/SSLeay/
./usr/lib/perl5/auto/Net/SSLeay/SSLeay.so
./lib64/
./lib64/ld-linux-x86-64.so.2
./bin/
./bin/ln
./bin/date
./bin/chgrp
./bin/sleep
./bin/sed
./bin/dir
./bin/bash
./bin/true
./bin/false
./bin/mkdir
./bin/dash
./bin/chown
./bin/cp
./bin/touch
./bin/rmdir
./bin/stty
./bin/mktemp
./bin/pwd
./bin/df
./bin/rm
./bin/readlink
./bin/cat
./bin/vdir
./bin/echo
./bin/chmod
./bin/mv
./bin/mknod
./bin/ls
./bin/sync
./bin/dd
./lib/
./lib/x86_64-linux-gnu/
./lib/x86_64-linux-gnu/libresolv.so.2
./lib/x86_64-linux-gnu/libselinux.so.1
./lib/x86_64-linux-gnu/libnss_files-2.15.so
./lib/x86_64-linux-gnu/libthread_db.so.1
./lib/x86_64-linux-gnu/libnsl.so.1
./lib/x86_64-linux-gnu/libresolv-2.15.so
./lib/x86_64-linux-gnu/libbz2.so.1.0
./lib/x86_64-linux-gnu/libkeyutils.so.1
./lib/x86_64-linux-gnu/libperl.so.5.14.2
./lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
./lib/x86_64-linux-gnu/libtinfo.so.5.9
./lib/x86_64-linux-gnu/libcom_err.so.2
./lib/x86_64-linux-gnu/libexpat.so.1.6.0
./lib/x86_64-linux-gnu/libnss_nisplus-2.15.so
./lib/x86_64-linux-gnu/libc.so.6
./lib/x86_64-linux-gnu/libgpg-error.so.0
./lib/x86_64-linux-gnu/libpcprofile.so
./lib/x86_64-linux-gnu/libpcre.so.3
./lib/x86_64-linux-gnu/libbz2.so.1
./lib/x86_64-linux-gnu/libutil-2.15.so
./lib/x86_64-linux-gnu/libBrokenLocale-2.15.so
./lib/x86_64-linux-gnu/liblzma.so.5.0.0
./lib/x86_64-linux-gnu/libz.so.1.2.7
./lib/x86_64-linux-gnu/libm.so.6
./lib/x86_64-linux-gnu/libacl.so.1.1.0
./lib/x86_64-linux-gnu/libgcc_s.so.1
./lib/x86_64-linux-gnu/libutil.so.1
./lib/x86_64-linux-gnu/libnss_nis-2.15.so
./lib/x86_64-linux-gnu/libglib-2.0.so.0.3400.1
./lib/x86_64-linux-gnu/libgpg-error.so.0.8.0
./lib/x86_64-linux-gnu/libnss_hesiod-2.15.so
./lib/x86_64-linux-gnu/libnss_hesiod.so.2
./lib/x86_64-linux-gnu/libglib-2.0.so.0
./lib/x86_64-linux-gnu/libssl.so.1.0.0
./lib/x86_64-linux-gnu/libkeyutils.so.1.4
./lib/x86_64-linux-gnu/libnss_dns.so.2
./lib/x86_64-linux-gnu/libnss_files.so.2
./lib/x86_64-linux-gnu/ld-2.15.so
./lib/x86_64-linux-gnu/libcom_err.so.2.1
./lib/x86_64-linux-gnu/libz.so.1
./lib/x86_64-linux-gnu/libnss_compat.so.2
./lib/x86_64-linux-gnu/libmemusage.so
./lib/x86_64-linux-gnu/libattr.so.1.1.0
./lib/x86_64-linux-gnu/libdl-2.15.so
./lib/x86_64-linux-gnu/libbz2.so.1.0.4
./lib/x86_64-linux-gnu/libnss_dns-2.15.so
./lib/x86_64-linux-gnu/liblzma.so.5
./lib/x86_64-linux-gnu/libpcre.so.3.13.1
./lib/x86_64-linux-gnu/libgcrypt.so.11
./lib/x86_64-linux-gnu/libBrokenLocale.so.1
./lib/x86_64-linux-gnu/librt-2.15.so
./lib/x86_64-linux-gnu/libpthread-2.15.so
./lib/x86_64-linux-gnu/libnss_nis.so.2
./lib/x86_64-linux-gnu/libdl.so.2
./lib/x86_64-linux-gnu/libcrypto.so.1.0.0
./lib/x86_64-linux-gnu/libcrypt-2.15.so
./lib/x86_64-linux-gnu/libanl-2.15.so
./lib/x86_64-linux-gnu/libacl.so.1
./lib/x86_64-linux-gnu/libnss_nisplus.so.2
./lib/x86_64-linux-gnu/librt.so.1
./lib/x86_64-linux-gnu/libtinfo.so.5
./lib/x86_64-linux-gnu/libanl.so.1
./lib/x86_64-linux-gnu/libpthread.so.0
./lib/x86_64-linux-gnu/libnsl-2.15.so
./lib/x86_64-linux-gnu/libgcrypt.so.11.7.0
./lib/x86_64-linux-gnu/libnss_compat-2.15.so
./lib/x86_64-linux-gnu/libSegFault.so
./lib/x86_64-linux-gnu/libcidn.so.1
./lib/x86_64-linux-gnu/libcidn-2.15.so
./lib/x86_64-linux-gnu/libcrypt.so.1
./lib/x86_64-linux-gnu/libc-2.15.so
./lib/x86_64-linux-gnu/libperl.so.5.14
./lib/x86_64-linux-gnu/libexpat.so.1
./lib/x86_64-linux-gnu/libm-2.15.so
./lib/x86_64-linux-gnu/libattr.so.1
./lib/x86_64-linux-gnu/libthread_db-1.0.so
</pre>

##Building a compatible icecc##

In order to have icecc working inside the chroot we have to patch it. The patch basically creates an environment variable (ICECC_PLATFORM) to override the toolchain host architecture.

Get the patch from the repository in creating-sdk/icecc/architecture_override.patch

<pre>
ICECC_DIR=icecc-`apt-cache show icecc| grep "^Version:" | cut -d ' ' -f 2`
apt-get source icecc
cp architecture_override.patch $ICECC_DIR/debian/patches
echo architecture_override.patch >> $ICECC_DIR/debian/patches/series
sudo apt-get install build-deps icecc
cd $ICECC_DIR
dpkg-buildpackage -us -uc -rfakeroot -b
</pre>

The following binaries must be copied to native-tools tarball

<pre>
/usr/bin/icecc
/usr/sbin/icecc-scheduler
/usr/sbin/iceccd
</pre>

#Creating the SDK#

Run the following commands.

<pre>
sudo apt-get install -y debootstrap
sudo debootstrap --foreign --no-check-gpg --arch armhf wheezy rpi-sdk http://archive.raspbian.org/raspbian
sudo apt-get install -y qemu-user-static
sudo cp /usr/bin/qemu-arm-static rpi-sdk/usr/bin/
sudo chroot rpi-sdk /debootstrap/debootstrap --second-stage
sudo mount -t proc proc rpi-sdk/proc
sudo mount -t sysfs sysfs rpi-sdk/sys
sudo mount -t devtmpfs udev rpi-sdk/dev
sudo mount -t devpts devpts rpi-sdk/dev/pts
sudo chroot rpi-sdk
export LC_ALL=C
export HOME=/root
cd
mkdir /.sdk
echo "deb http://archive.raspbian.org/raspbian wheezy main rpi non-free contrib" >> /etc/apt/sources.list
echo "deb http://archive.raspberrypi.org/debian/ wheezy main untested" >> /etc/apt/sources.list
wget http://archive.raspbian.org/raspbian.public.key -O - | apt-key add -
wget http://archive.raspberrypi.org/debian/raspberrypi.gpg.key -O - | apt-key add -
apt-get update
apt-get install -y pkg-config autoconf automake intltool libtool g++ gcc make git vim bzip2 libxml2-dev zlib1g-dev libpng12-dev python gtk-doc-tools libgnutls-dev libicu-dev libraspberrypi-dev cmake gobject-introspection icon-naming-utils libgcrypt11-dev libgpg-error-dev libp11-kit-dev libtiff4-dev libcroco3-dev gettext flex bison gperf libsqlite3-dev libxslt1-dev libavcodec-dev sudo icecc
apt-get clean

# Configuring 'pi' user
useradd -m pi -s /bin/bash
echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi
chmod go-rw /etc/sudoers.d/pi

# Workaround to make uname return armv6 
echo "export QEMU_CPU=arm1176" >> /home/pi/.profile

# Workaround to make ldd works also to x86_64 binaries (needed to make icecc works)
sed -i 's,\(^RTLDLIST=".*\)",\1 /lib64/ld-linux-x86-64.so.2",' /usr/bin/ldd

# Pinning packages that cannot be updated (will be overwritten by native tools)
for i in libnet-ssleay-perl liblocale-gettext-perl libhtml-parser-perl libtext-iconv-perl libtext-charwidth-perl libsocket-perl libxml-parser-perl perl-base perl sed coreutils m4 cmake make bash dash git libc6 icecc; do echo $i hold | dpkg --set-selections; done
exit

# Manually installing pkgconfig files for raspberry libraries
git clone http://cgit.collabora.com/git/user/pq/android-pc-files.git -b raspberrypi --single-branch
sudo cp android-pc-files/pkgconfig/* rpi-sdk/usr/share/pkgconfig/.
rm -rf android-pc-files

# Extract the toolchain tarball you have built (see previous sections)
pushd rpi-sdk
sudo tar xf ../toolchain-chroot-x86_64.tar.bz2
popd

# Extract the native tools tarball you have built (see previous sections)
pushd rpi-sdk
sudo tar xf ../native-tools-x86_64.tar.bz2
popd

# Preparing tarball for release
sudo umount rpi-sdk/proc
sudo umount rpi-sdk/sys
sudo umount rpi-sdk/dev/pts
sudo umount rpi-sdk/dev
sudo tar cJf rpi-sdk-x86_64.tar.xz rpi-sdk
</pre>

#SDK FAQ#

###How did we choose the native tools?###

The main goal is accelerate the webkit build. So, all applications that are relevant to the build (and their dependencies) must have the native version into the chroot. They are:

* Bash
* Dash
* Perl
* Make
* Cmake
* Git
* M4
* Sed
* Coreutils
* Icecc

###How native applications can work into an arm chroot?###

**Short answer**: because there is support to multiarch

**Long answer**: http://wiki.debian.org/Multiarch

###What is needed in the chroot?###

You have to copy to the chroot:

* Binary
* Native loader (to the same path)
* Dynamic libraries linked to your binary (to a path known by the loader)
* Libraries dynamic loaded during runtime (dlopen)

###Do I need to copy non-binary files (configuration files, scripts, etc) to the chroot?###

No. You can install the arm package into chroot and overwrite the binaries. But take care with version conflicts.
