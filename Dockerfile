FROM 32bit/debian

MAINTAINER Fecana

RUN apt-get update \
	&& apt-get install -y curl \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" > /etc/apt/sources.list.d/mono-xamarin.list \
	&& apt-get update \
	&& echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" >> /etc/apt/sources.list.d/mono-xamarin.list \
	&& echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" >> /etc/apt/sources.list.d/mono-xamarin.list \
	&& apt-get update
	&& apt-get install -y mono-devel mono-vbnc nuget \
	&& rm -rf /var/lib/apt/lists/*

# we need to fetch an ancient version of certdata (from 2009) because newer versions run into a Mono bug: https://github.com/mono/mono/pull/1514
# this is the same file that was used in the old mozroots before https://github.com/mono/mono/pull/3188 so nothing really changes (but still less than ideal)
RUN curl -L -o /tmp/certdata.txt https://hg.mozilla.org/releases/mozilla-release/raw-file/5d447d9abfdf/security/nss/lib/ckfw/builtins/certdata.txt
RUN mozroots --machine --import --sync --quiet --file /tmp/certdata.txt
​
