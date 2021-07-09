FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install --no-install-recommends -y \
		gnupg && \
	apt-get clean

ADD	keys/074BCDE4.asc /tmp/
RUN	echo "deb http://fai-project.org/download buster koeln" >> /etc/apt/sources.list && \
	apt-key add /tmp/074BCDE4.asc && \
	rm -f /tmp/074BCDE4.asc

RUN	apt-get update && \
	apt-get upgrade -y && \
	apt-get install --no-install-recommends -y \
		apt-cacher-ng \
		apt-transport-https \
		aptitude \
		binutils \
		bzip2 \
		initramfs-tools- \
		ca-certificates \
		fai-client=5.8.4 \
		fai-server=5.8.4 \
		isc-dhcp-server- \
		nfs-kernel-server- \
		openbsd-inetd- \
		openssh-server- \
		tcpd- \
		tftpd-hpa- \
		update-inetd- \
		debian-archive-keyring \
		gawk \
		grub-pc-bin \
		less \
		liblz4-tool \
		memtest86+ \
		openssh-client \
		patch \
		reprepro \
		tzdata \
		vim \
		wget \
		xorriso \
		xz-utils && \
	apt-get clean

ADD	fai /etc/fai/
ADD	hooks /etc/fai/nfsroot-hooks/
ADD	bin /usr/local/bin/
ADD	patches /tmp/
ADD	keys /etc/fai/apt/keys/

RUN	patch /usr/bin/fai-mirror < /tmp/fai-mirror.patch && \
	patch /usr/sbin/fai-make-nfsroot < /tmp/fai-make-nfsroot.patch && \
	patch /etc/fai/nfsroot.conf < /tmp/nfsroot.patch && \
	rm -f \
		/tmp/fai-make-nfsroot.patch \
		/tmp/nfsroot.patch \
		/tmp/fai-mirror.patch \
		/usr/sbin/fai-make-nfsroot.orig \
		/usr/bin/fai-mirror.orig \
		/etc/fai/nfsroot.conf.orig

RUN	sed -ri 's/^(# )?Port:3142/Port:9999/' /etc/apt-cacher-ng/acng.conf && \
	sed -ri 's/^Remap-(gentoo|sfnet):/#&/' /etc/apt-cacher-ng/acng.conf && \
	cp /etc/apt/sources.list /etc/fai/apt/ && \
	sed -i 's%http://%&127.0.0.1:9999/%' /etc/fai/apt/sources.list && \
	mkdir -p /etc/fai/faimirror/apt && \
	cp /etc/fai/fai.conf /etc/fai/faimirror && \
	cp /etc/fai/nfsroot.conf /etc/fai/faimirror && \
	chmod +x /etc/fai/nfsroot-hooks/* && \
	chmod +x /usr/local/bin/*

VOLUME	/var/cache/apt-cacher-ng

CMD /etc/init.d/apt-cacher-ng start && \
	/bin/bash
