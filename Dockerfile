FROM debian:stable-slim AS base

ARG GODOT_VERSION=3.4.2

RUN apt update && apt install -y --no-install-recommends \
	apt-transport-https \
	dirmngr \
	gnupg \
	ca-certificates \
	wget \
	unzip \
	scons

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
#RUN echo "deb https://download.mono-project.com/repo/debian stable-stretch main" | tee /etc/apt/sources.list.d/mono-official-stable.list
	
#RUN apt update && apt install -y mono-devel


RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip
RUN unzip Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip
RUN ln -s /Godot_v${GODOT_VERSION}-stable_linux_headless.64 /usr/local/bin/godot-headless

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_server.64.zip
RUN unzip Godot_v${GODOT_VERSION}-stable_linux_server.64.zip
RUN ln -s /Godot_v${GODOT_VERSION}-stable_linux_server.64 /usr/local/bin/godot

#RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/mono/Godot_v${GODOT_VERSION}-stable_mono_linux_headless_64.zip
#RUN unzip Godot_v${GODOT_VERSION}-stable_mono_linux_headless_64.zip
#RUN ln -s /Godot_v${GODOT_VERSION}-stable_mono_linux_headless_64/Godot_v${GODOT_VERSION}-stable_mono_linux_headless.64 /usr/local/bin/godot-headless

#RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/mono/Godot_v${GODOT_VERSION}-stable_mono_linux_server_64.zip
#RUN unzip Godot_v${GODOT_VERSION}-stable_mono_linux_server_64.zip
#RUN ln -s /Godot_v${GODOT_VERSION}-stable_mono_linux_server_64/Godot_v${GODOT_VERSION}-stable_mono_linux_server.64 /usr/local/bin/godot

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz
RUN mkdir -p /root/.local/share/godot/templates
RUN unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz
RUN mv templates /root/.local/share/godot/templates/${GODOT_VERSION}.stable
#RUN mv templates /root/.local/share/godot/templates/${GODOT_VERSION}.stable.mono

WORKDIR /app
COPY godot_files .
#WORKDIR /app/godot_files/addon_src/godot_heightmap_plugin/addons/zylann.hterrain/native/godot_cpp
#RUN scons platform=linux generate_bindings=yes target=release
#WORKDIR /app/godot_files/addon_src/godot_heightmap_plugin/addons/zylann.hterrain/native
#RUN scons platform=linux target=release

#WORKDIR /app
#RUN rm -rf /app/godot_files/addons/zylann.hterrain
#RUN cp -r /app/godot_files/addon_src/godot_heightmap_plugin/addons/zylann.hterrain /app/godot_files/addons/.

RUN godot-headless --path . --export "Linux_Server" ./.builds/hterrain_server

WORKDIR /app/.builds
CMD ["godot", "--main-pack", "/app/.builds/hterrain_server.pck"]
